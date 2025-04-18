<?php

class OkimodalsPopupModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();

        $type = Tools::getValue('type');
        $tpl = '';
        $assign = [];

        switch ($type) {
            case 'add_to_cart':
                $id_product = (int)Tools::getValue('id_product');
                $product = new Product($id_product, false, $this->context->language->id);
                $cover = Product::getCover($product->id); 

                $locale = Context::getContext()->getCurrentLocale();
                $currencyCode = Context::getContext()->currency->iso_code;
                
                $price = $product->getPrice(true); // true = with tax
                $formattedPrice = $locale->formatPrice($price, $currencyCode);

                $link = Context::getContext()->link;
                if ($cover) {
                    $image = $link->getImageLink($product->link_rewrite, $cover['id_image'], 'home_default');
                } else {
                    $image = null;
                }
                
                // get related products
                $relatedProducts = [];
                $relatedRaw = Product::getAccessoriesLight($this->context->language->id, $id_product);

                if (count($relatedRaw) > 0) {
                    $relatedProducts = $this->getProductData($relatedRaw);
                }

                // or the similar products
                $similarProducts = [];
                if (count($relatedRaw) == 0) {
                    $id_category = (int)$product->id_category_default;

                    $similarRaw= Product::getProducts(
                        $this->context->language->id,
                        0, 10, 'position', 'asc',
                        $id_category,
                        true
                    );

                    $similarRaw = array_filter($similarRaw, fn($p) => $p['id_product'] != $id_product);
                    
                    $similarProducts = $this->getProductData($similarRaw);
                }

                $assign = [
                    'product' => $product,
                    'image' => $image,
                    'price' => $formattedPrice,
                    'related' => $relatedProducts,
                    'similar' => $similarProducts
                ];

                $tpl = 'module:okimodals/views/templates/front/modal-add-to-cart.tpl';
                break;

            case 'newsletter':
                $assign = ['title' => 'Thanks for signing up!'];
                $tpl = 'module:okimodals/views/templates/front/modal-newsletter.tpl';
                break;

            case 'custom':
                $assign = ['message' => 'Custom message here'];
                $tpl = 'module:okimodals/views/templates/front/modal-custom.tpl';
                break;

            default:
                $assign = ['message' => 'Default modal'];
                $tpl = 'module:okimodals/views/templates/front/modal-default.tpl';
        }

        $this->context->smarty->assign($assign);
        $html = $this->module->fetch($tpl);

        header('Content-Type: application/json');
        die(json_encode(['modal' => $html]));
    }

    public function getProductData($products) {
        $context = Context::getContext();
        $locale = $context->currentLocale;
        $currency = $context->currency;
        $id_lang = $context->language->id;
        
        $formattedProducts = [];

        foreach ($products as $product) {
            $newProduct = new Product((int)$product['id_product'], false, $this->context->language->id);
            
            $productData['flags'] = [];
            $price = $newProduct->getPrice();
            $manufacturer = new Manufacturer($newProduct->id_manufacturer);
            $link = Context::getContext()->link;
            $cover = Product::getCover($newProduct->id);

            if ($cover) {
                $image = $link->getImageLink($newProduct->link_rewrite, $cover['id_image'], 'home_default');
            } else {
                $image = null;
            }

            $regularPrice = $newProduct->getPriceWithoutReduct(false);
            if ($price < $regularPrice) {
                $productData['has_discount'] = true;
                $productData['discount_amount'] = $regularPrice - $price;
                $productData['discount_percent'] = round(($productData['discount_amount'] / $regularPrice) * 100);
                $productData['flags'][] = array('type' => 'discount', 'label' => '-'.$productData['discount_percent'].'%');
            } else {
                $productData['has_discount'] = false;
                $productData['flags'] = [];
            }
            
            $productData['id'] = $newProduct->id;
            $productData['price'] = $locale->formatPrice($price, $currency->iso_code);
            $productData['old_price'] = $locale->formatPrice($regularPrice, $currency->iso_code);
            $productData['name'] = $newProduct->name;  
            $productData['brand'] = $manufacturer->name;
            $productData['url'] = $newProduct->getLink(); 
            $productData['cover'] = $image;

            $formattedProducts[] = $productData;
        }

        return $formattedProducts;
    }
}
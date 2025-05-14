<?php

class CartController extends CartControllerCore
{
    public function initContent()
    {
        parent::initContent();

        $products = $this->context->cart->getProducts();
        $recommendList = [];
        $ids = [];
        $context = Context::getContext();
        $link = $context->link;
        $locale = Context::getContext()->getCurrentLocale();
        $currencyCode = Context::getContext()->currency->iso_code;

        // get product ids from cart in order to filter them in recommended
        foreach ($products as &$product) {
            $ids[] = (int) $product['id_product'];
        }

        foreach ($products as &$product) {
            $list = $this->getAccessories((int) $product['id_product']);

            if (!empty($list)) {
                foreach ($list as $item) {
                    if (!in_array($item["id_product"], $ids)) {
                        $newProduct = new Product($item["id_product"], true, $this->context->language->id);;

                        $idCustomer = $context->customer->id;
                        $idCart = $context->cart->id;
                        $idCurrency = $context->currency->id;
                        $idCountry = $context->country->id;
                        $idGroup = $context->customer->id_default_group;
                        
                        // Get original price (without discount)
                        $finalPrice = Product::getPriceStatic(
                            $item["id_product"],
                            true,
                            "",
                            6,
                            null,
                            false,
                            true, 
                            1,
                            false,
                            $idCustomer,
                            $idCart,
                            $idCustomer,
                            $idGroup,
                            $idCurrency,
                            $idCountry
                        );
                        // Get final price (with discount)
                        $originalPrice = Product::getPriceStatic(
                            $item["id_product"],
                            true,
                            "",
                            6,
                            null,
                            false,
                            false,
                            1,
                            false,
                            $idCustomer,
                            $idCart,
                            $idCustomer,
                            $idGroup,
                            $idCurrency,
                            $idCountry
                        );

                        $flags = [];
                        if ($originalPrice > $finalPrice) {
                            $has_discount = $originalPrice > $finalPrice;
                            $discountPercent = round((($originalPrice - $finalPrice) / $finalPrice) * 100);

                            $flags = [
                                'type' => 'discount',
                                'label' => '-'.$discountPercent.'%'
                            ];
                        }

                        // get product url
                        $url = $link->getProductLink(
                            $item["id_product"],
                            null,
                            null,
                            null,
                            $context->language->id,
                            null,
                            "",
                            false,
                            false,
                            true
                        );

                        // get product picture
                        $link = new Link(); 
                        $imageUrl = '';    

                        if (Validate::isLoadedObject($newProduct)) {
                            $cover = Product::getCover((int)$newProduct->id);
                            if ($cover && isset($cover['id_image'])) {
                                $imageId = $cover['id_image'];
                                $imageUrl = $link->getImageLink($newProduct->link_rewrite, $imageId, 'home_default');
                            }
                        }

                        // get brand info
                        $brandName = '';
                        $brandUrl = '';
                        if ($newProduct->id_manufacturer) {
                            $manufacturer = new Manufacturer($product->id_manufacturer, $context->language->id);
                            $brandName = $manufacturer->name;
                            $brandUrl = Context::getContext()->link->getManufacturerLink($manufacturer->id, $manufacturer->link_rewrite);
                        }

                        $recommendList[] = [
                            'id' => $item["id_product"],
                            'name' => $newProduct->name,
                            'url' => $url,
                            'cover' => $imageUrl,
                            'has_discount' => $has_discount,
                            'original_price' => $locale->formatPrice($originalPrice, $currencyCode),
                            'final_price' => $locale->formatPrice($finalPrice, $currencyCode),
                            'flags' => $flags,
                            'brand_name' => $brandName,
                            'brand_url' => $brandUrl
                        ];
                    }
                }
            }
        }

        // print_r($recommendList);
        $this->context->smarty->assign([
            'recommended' => $recommendList,
        ]);
    }

    /**
     * Get accessories for a product.
     */
    protected function getAccessories($productId)
    {
        $idLang = (int) $this->context->language->id;
        return Product::getAccessoriesLight($idLang, $productId);
    }
}
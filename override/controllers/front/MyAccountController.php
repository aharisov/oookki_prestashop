<?php

class MyAccountController extends MyAccountControllerCore
{
    public function initContent()
    {
        parent::initContent();

        // get viewed products from cookie
        $viewedIds = isset($_COOKIE['viewed_products']) ? explode(',', $_COOKIE['viewed_products']) : [];

        $context = Context::getContext();
        $link = $context->link;
        $locale = Context::getContext()->getCurrentLocale();
        $currencyCode = Context::getContext()->currency->iso_code;

        $products = [];
        foreach ($viewedIds as $id) {
            if ((int)$id > 0) {
                $product = new Product((int)$id, true, (int)$this->context->language->id);

                $idCustomer = $context->customer->id;
                $idCart = $context->cart->id;
                $idCurrency = $context->currency->id;
                $idCountry = $context->country->id;
                $idGroup = $context->customer->id_default_group;
                
                // Get original price (without discount)
                $finalPrice = Product::getPriceStatic(
                    $id,
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
                    $id,
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
                    $id,
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

                if (Validate::isLoadedObject($product)) {
                    $cover = Product::getCover((int)$id);
                    if ($cover && isset($cover['id_image'])) {
                        $imageId = $cover['id_image'];
                        $imageUrl = $link->getImageLink($product->link_rewrite, $imageId, 'home_default');
                    }
                }

                // get brand info
                $brandName = '';
                $brandUrl = '';
                if ($product->id_manufacturer) {
                    $manufacturer = new Manufacturer($product->id_manufacturer, $context->language->id);
                    $brandName = $manufacturer->name;
                    $brandUrl = Context::getContext()->link->getManufacturerLink($manufacturer->id, $manufacturer->link_rewrite);
                }

                $products[] = [
                    'id' => $id,
                    'name' => $product->name,
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

        $this->context->smarty->assign([
            'viewed_products' => $products,
        ]);
    }
}
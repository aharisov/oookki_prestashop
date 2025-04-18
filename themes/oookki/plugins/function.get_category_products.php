<?php
use PrestaShop\PrestaShop\Core\Search\Filters\ProductSearchFilter;
use PrestaShop\PrestaShop\Core\Localization\Locale;
function smarty_function_get_category_products($params, &$smarty)
{
    $context = Context::getContext();
    $locale = $context->currentLocale;
    $currency = $context->currency;
    $id_lang = $context->language->id;
    $categoryIds = $params['categories'];
    $limit = $params['limit'];

    $cacheKey = 'product_search_' . implode('_', $categoryIds) . '_lang_' . $id_lang;

    // Check if the data is already cached
    if (Cache::isStored($cacheKey)) {
        // Get products from the cache
        $products = Cache::retrieve($cacheKey);
    } else {
        // Get product IDs from those categories
        $sql = 'SELECT DISTINCT cp.id_product
                FROM ' . _DB_PREFIX_ . 'category_product cp
                INNER JOIN ' . _DB_PREFIX_ . 'product p ON (p.id_product = cp.id_product)
                WHERE cp.id_category IN (' . implode(',', array_map('intval', $categoryIds)) . ')
                AND p.active = 1
                ORDER BY RAND()
                LIMIT ' . $limit;

        $productIds = Db::getInstance()->executeS($sql);

        $products = [];
        foreach ($productIds as $row) {
            $product = new Product((int)$row['id_product'], false, $id_lang);

            // $productArray = $product->getFields();
            $productData['flags'] = [];
            
            $price = $product->getPrice();
            $manufacturer = new Manufacturer($product->id_manufacturer);
            $link = Context::getContext()->link;
            $cover = Product::getCover($product->id);

            if ($cover) {
                $image = $link->getImageLink($product->link_rewrite, $cover['id_image'], 'home_default');
            } else {
                $image = '/img/p/fr-default-home_default.jpg';
            }

            $regularPrice = $product->getPriceWithoutReduct(false);
            if ($price < $regularPrice) {
                $productData['has_discount'] = true;
                $productData['discount_amount'] = $regularPrice - $price;
                $productData['discount_percent'] = round(($productData['discount_amount'] / $regularPrice) * 100);
                $productData['flags'][] = array('type' => 'discount', 'label' => '-'.$productData['discount_percent'].'%');
            } else {
                $productData['has_discount'] = false;
                $productData['flags'] = [];
            }
            
            $productData['id'] = $product->id;
            $productData['price'] = $locale->formatPrice($price, $currency->iso_code);
            $productData['old_price'] = $locale->formatPrice($regularPrice, $currency->iso_code);
            $productData['name'] = $product->name;  
            $productData['brand'] = $manufacturer->name;
            $productData['url'] = $product->getLink(); 
            $productData['cover'] = $image;
            
            $context = Context::getContext();
            $quantity = $context->cart->getProductQuantity((int)$product->id, 0);
            $productData['cart_quantity'] = $quantity['quantity'];

            if ($product->isNew()) {
                $productData['flags'][] = array('type' => 'new', 'label' => 'Nouveau');
            }

            // Add product data to the array
            if (Validate::isLoadedObject($product)) {
                $products[] = $productData;
            }
        }

        // Store the result in the cache for 3600 seconds (1 hour)
        Cache::store($cacheKey, $products);
    }

    if (isset($params['assign'])) {
        $smarty->assign([
            $params['assign'], 
            'urls' => [
                'pages' => [
                    'cart' => $link->getPageLink('cart', true),
                ],
            ],
            'static_token' => Tools::getToken(false),
            'products' => $products
        ]);
        return '';
    }

    return json_encode($products);
}

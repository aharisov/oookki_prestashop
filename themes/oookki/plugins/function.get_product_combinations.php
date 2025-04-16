<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Adapter\Entity\Product;
use PrestaShop\PrestaShop\Adapter\Entity\StockAvailable;

function smarty_function_get_product_combinations($params, &$smarty)
{
    if (!isset($params['id_product'])) {
        return '';
    }
    $context = Context::getContext();

    $productObj = new Product((int)$params['id_product'], false, $context->language->id);
    $combinations = $productObj->getAttributeCombinations($context->language->id);

    $combinationData = [];

    $locale = $context->currentLocale;
    $currencyCode = $context->currency->iso_code;

    foreach ($combinations as $combination) {
        // echo 'comb';print_r($combination);
        $color = null;
        $storage = null;

        if ($combination['group_name'] == 'Couleur' || $combination['group_name'] == 'Color') {
            $color = $combination['attribute_name'];
        }

        if ($combination['group_name'] == 'Stockage' || $combination['group_name'] == 'Storage') {
            $storage = $combination['attribute_name'];
        }

        $idCombination = (int)$combination['id_product_attribute'];
        $qty = StockAvailable::getQuantityAvailableByProduct((int)$params['id_product'], $idCombination);

        $idCustomer = $context->customer->id;
        $idCart = $context->cart->id;
        $idCurrency = $context->currency->id;
        $idCountry = $context->country->id;
        $idGroup = $context->customer->id_default_group;
        
        // Get original price (without discount)
        $finalPrice = Product::getPriceStatic(
            $params['id_product'],
            true,
            $idCombination,
            2,
            null,
            false,
            true, // this disables specific price reduction
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
            $params['id_product'],
            true,
            $idCombination,
            2,
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
        $has_discount = $originalPrice > $finalPrice;

        if (!isset($combinationData[$idCombination])) {
            $combinationData[$idCombination] = [
                'id' => $idCombination,
                'color' => null,
                'storage' => null,
                'qty' => $qty,
                'price' => $locale->formatPrice($finalPrice, $currencyCode),
                'price_raw' => $finalPrice,
                'original_price' => $has_discount ? $locale->formatPrice($originalPrice, $currencyCode) : null,
            ];
        }

        if ($color) {
            $combinationData[$idCombination]['color'] = $color;
        }
        if ($storage) {
            $combinationData[$idCombination]['storage'] = $storage;
        }
    }

    // print_r($combinationData);
    $combinedGroups = [];
    // Get all combinations
    foreach ($combinationData as $entry) {
        // print_r($entry);
        if (!$entry['color'] || !$entry['storage']) {
            continue;
        }

        $color = $entry['color'];
        $storage = $entry['storage'];

        if (!isset($combinedGroups[$storage])) {
            $combinedGroups[$storage] = [];
        }

        $combinedGroups[$storage][$color] = [
            'id_combination' => $entry['id'],
            'qty' => $entry['qty'],
            'price' => $entry['price'],
            'price_raw' => $entry['price_raw'],
            'price_original' => $entry['original_price']
        ];
    }

    $storageStock = [];
    // Get all storage values with quantity
    foreach ($combinedGroups as $storage => $colors) {
        $totalQty = 0;
    
        foreach ($colors as $color => $data) {
            $totalQty += (int)$data['qty']; 
            $price = $data["price"];
            $priceOriginal = $data["price_original"];
            $priceRaw = $data["price_raw"];
        }
    
        $storageStock[$storage]["qty"] = $totalQty;
        $storageStock[$storage]["price"] = $price;
        $storageStock[$storage]["price_original"] = $priceOriginal;
        $storageStock[$storage]["price_raw"] = $priceRaw;
    }

    $comboData['attributes_extra'] = $combinedGroups;
    $comboData['attributes_storage'] = $storageStock;

    if (isset($params['assign'])) {
        $smarty->assign($params['assign'], $comboData);
        return '';
    }

    // print_r($storageStock);
    return json_encode($combinationData);
}

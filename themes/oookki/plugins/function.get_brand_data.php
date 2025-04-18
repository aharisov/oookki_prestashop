<?php
if (!defined('_PS_VERSION_')) {
    exit;
}

function smarty_function_get_brand_data($params, &$smarty)
{

    $brandData = null;

    $query = Tools::getValue('q');
    $context = Context::getContext();

    if ($query) {
        // find brand by name in the url
        if (preg_match('/Marque-(.*)/', $query, $matches)) {
            $brandName = urldecode($matches[1]);

            $manufacturer = Manufacturer::getIdByName($brandName);
            if ($manufacturer) {
                $brand = new Manufacturer($manufacturer, $context->language->id);
                $link = Context::getContext()->link;
                // print_r($brand);
                $brandData["name"] = $brand->name;
                $brandData["description"] = $brand->description;
                $brandData["image"] = $link->getManufacturerImageLink($brand->id);
            }
        }
    }

    if (isset($params['assign']) && $params['assign']) {
        $smarty->assign($params['assign'], $brandData);
    } else {
        return $brandData;
    }
}
        
<?php
use PrestaShop\PrestaShop\Adapter\Product\ProductColorsRetriever;
class CategoryController extends CategoryControllerCore
{
    public function init()
    {
        parent::init();
    
        if (Tools::getValue('ajax') && Tools::getValue('action') === 'getCombinationsForStorage') {
            $this->ajaxGetCombinationsForStorage();
            exit;
        }
    }

    public function initContent()
    {
        parent::initContent();

        $context = Context::getContext();
        $listing = $context->smarty->getTemplateVars('listing');

        if (!isset($listing['products']) || !is_array($listing['products'])) {
            return;
        }

        $id_category = (int)$this->category->id;

        // Choose different template based on category
        if ($id_category == 3) {
            $this->setTemplate('catalog/listing/category-forfaits.tpl');
        } else {
            $this->setTemplate('catalog/listing/category.tpl');
        }
        
        $context->smarty->assign('listing', $listing);
    }

    protected function ajaxGetCombinationsForStorage()
    {
        $context = Context::getContext();
        $idProduct = (int) Tools::getValue('id_product');
        $selectedStorage = Tools::getValue('storage'); 
        $link = $context->link;

        $productObj = new Product($idProduct, false, $context->language->id);
        $combinations = $productObj->getAttributeCombinations($context->language->id);

        $combinationData = [];

        foreach ($combinations as $combination) {
            $color = null;
            $storage = null;

            if ($combination['group_name'] == 'Couleur' || $combination['group_name'] == 'Color') {
                $color = $combination['attribute_name'];
            }

            if ($combination['group_name'] == 'Stockage' || $combination['group_name'] == 'Storage') {
                $storage = $combination['attribute_name'];
            }

            $idCombination = (int)$combination['id_product_attribute'];
            $qty = StockAvailable::getQuantityAvailableByProduct($idProduct, $idCombination);

            $idCustomer = $context->customer->id;
            $idCart = $context->cart->id;
            $idCurrency = $context->currency->id;
            $idCountry = $context->country->id;
            $idGroup = $context->customer->id_default_group;
            
            // Get original price (without discount)
            $finalPrice = Product::getPriceStatic(
                $idProduct,
                true,
                $idCombination,
                6,
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
                $idProduct,
                true,
                $idCombination,
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
            $has_discount = $originalPrice > $finalPrice;

            $url = $link->getProductLink(
                $idProduct,
                null,
                null,
                null,
                $context->language->id,
                null,
                $idCombination,
                false,
                false,
                true
            );

            $locale = Context::getContext()->getCurrentLocale();
            $currencyCode = Context::getContext()->currency->iso_code;

            if (!isset($combinationData[$idCombination])) {
                $combinationData[$idCombination] = [
                    'id' => $idCombination,
                    'color' => null,
                    'storage' => null,
                    'qty' => $qty,
                    'price' => $locale->formatPrice($finalPrice, $currencyCode),
                    'price_raw' => $finalPrice,
                    'original_price' => $has_discount ? $locale->formatPrice($originalPrice, $currencyCode) : null,
                    'url' => $url
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
        $result = [];

        foreach ($combinationData as $item) {
            if ($item['storage'] == $selectedStorage) {
                if (!$item['color'] || !$item['storage']) {
                    continue;
                }

                $color = $item['color'];
                $storage = $item['storage'];

                $result[$color] = [
                    'id_combination' => $item['id'],
                    'qty' => $item['qty'],
                    'price' => $item['price'],
                    'price_raw' => $item['price_raw'],
                    'price_original' => $item['original_price'],
                    'url' => $item['url']
                ];

            }
        }

        header('Content-Type: application/json');
        echo json_encode([
            'success' => true,
            'data' => $result
        ]);
        die;
    }

}

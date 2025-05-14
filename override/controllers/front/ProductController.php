<?php
require_once _PS_MODULE_DIR_ . 'okicustomprops/classes/OkiCustomProp.php';
class ProductController extends ProductControllerCore
{
    public function init()
    {
        parent::init();

        $this->assignNewCombinations();
    }

    public function initContent()
    {
        parent::initContent();

        // Get the product
        $id_product = (int)Tools::getValue('id_product');
        $product = new Product($id_product, true, $this->context->language->id);

        // Fetch the custom properties for the product
        // $customProps = OkiCustomProp::getProductProps($id_product, $product->id_category_default);

        // // Assign the custom properties to the smarty variables
        // $this->context->smarty->assign([
        //     'custom_props' => $customProps,
        // ]);
    }
    protected function assignNewCombinations()
    {
        parent::assignAttributesCombinations();

        $product = $this->product;
        $combinations = $product->getAttributeCombinations($this->context->language->id);
        $grouped = [];
        $key = null;

        foreach ($combinations as $row) {
            if ($row['group_name'] === 'Stockage') {
                $key = $row['attribute_name'];
                
                if (!isset($grouped[$key])) {
                    $grouped[$key] = [
                        'id' => $row['id_attribute'],
                        'colors' => []
                    ];
                }
            } else {
                $grouped[$key]['colors'][$row['attribute_name']] = $row['quantity'];
            }
        }

        // echo '<pre>'; print_r($grouped); echo '</pre>';
        $this->context->smarty->assign('new_combinations', $grouped);
    }
}

<?php
require_once _PS_MODULE_DIR_ . 'okicustomprops/classes/OkiCustomProp.php';
class OkicustompropsAjaxModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();

        if (Tools::getValue('ajax') && Tools::getValue('action') === 'getAjaxProductProps') {
            $this->getAjaxProductProps((int)Tools::getValue('id_product'));
        }

        if (Tools::getValue('ajax') && Tools::getValue('action') === 'getAjaxProductDescrProps') {
            $this->getAjaxProductDescrProps((int)Tools::getValue('id_product'));
        }

        // Fallback or 404
        die('Invalid call');
    }

    public function getAjaxProductProps($id_product)
    {
        $product = new Product($id_product, true, $this->context->language->id);
        
        $features = Product::getFeaturesStatic($id_product);
        $customProps = OkiCustomProp::getProductProps($id_product, $product->id_category_default);
        
        $storage = [];
        $colors = [];
        $attributes = $product->getAttributeCombinations($this->context->language->id);
        foreach ($attributes as $attribute) {
            // echo '<pre>'; print_r($attribute); echo '</pre>';
            $group_name = $attribute['group_name'];
            $attribute_name = $attribute['attribute_name'];
            $id_attribute = (int)$attribute['id_attribute'];
        
            if (strtolower($group_name) == 'stockage') {
                $storage[] = $attribute_name;
            }
        
            if (strtolower($group_name) == 'couleur') {
                // Get color code manually
                $color_code = Db::getInstance()->getValue('
                    SELECT color
                    FROM '._DB_PREFIX_.'attribute
                    WHERE id_attribute = '.(int)$id_attribute
                );
        
                $colors[$attribute_name] = [
                    'code' => $color_code,
                ];
            }
        }

        $storage = array_unique($storage);

        $mainFeatures = [];
        $featureIds = [1, 3, 5];
        foreach ($features as $feature) {
            if (in_array($feature['id_feature'],$featureIds)) {
                $featureValue = FeatureValue::getFeatureValueLang((int)$feature['id_feature_value']);
                $featureName = Feature::getFeature($this->context->language->id, $feature['id_feature']);
                
                // echo '<pre>'; print_r($featureValue); echo '</pre>';
                foreach ($featureValue as $val) {
                    if (2 == $val['id_lang']) {
                        $mainFeatures[$feature['id_feature']]['name'] = $featureName['name'];
                        $mainFeatures[$feature['id_feature']]['value'] = $val['value'];
                    }
                }
            }
        }

        $this->context->smarty->assign([
            'raw_features' => $features,
            'main_features' => $mainFeatures,
            'custom_props' => $customProps,
            'colors' => $colors,
            'storage' => $storage
        ]);

        $html = $this->context->smarty->fetch(_PS_MODULE_DIR_ . 'okicustomprops/views/templates/front/product_props.tpl');

        die(json_encode([
            'success' => true,
            'html' => $html,
        ]));
    }

    public function getAjaxProductDescrProps($id_product)
    {
        $product = new Product($id_product, true, $this->context->language->id);
        
        $features = Product::getFeaturesStatic($id_product);

        $featureIds = [
            18 => 'title',
            19 => 'video',
            20 => 'image',
            21 => 'text',
        ];
        
        $groupedFeatures = [];
        
        // Collect values by feature ID
        foreach ($features as $feature) {
            if (isset($featureIds[$feature['id_feature']])) {
                $featureValues = FeatureValue::getFeatureValueLang((int) $feature['id_feature_value']);
                foreach ($featureValues as $val) {
                    if ($val['id_lang'] == 2) {
                        $groupedFeatures[$feature['id_feature']][] = $val['value'];
                    }
                }
            }
        }
        
        // Merge by index
        $result = [];
        $maxCount = max(array_map('count', $groupedFeatures));
        
        for ($i = 0; $i < $maxCount; $i++) {
            $item = [];
            foreach ($featureIds as $id => $key) {
                $item[$key] = isset($groupedFeatures[$id][$i]) ? $groupedFeatures[$id][$i] : null;
            }
            $result[] = $item;
        }
        
        // echo '<pre>'; print_r($result); echo '</pre>';

        $fullDescription = $product->description;

        $this->context->smarty->assign([
            'blocks' => $result,
            'description' => $fullDescription
        ]);

        $html = $this->context->smarty->fetch(_PS_MODULE_DIR_ . 'okicustomprops/views/templates/front/product_description.tpl');

        die(json_encode([
            'success' => true,
            'html' => $html,
        ]));
    }
}

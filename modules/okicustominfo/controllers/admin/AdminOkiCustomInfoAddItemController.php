<?php
require_once _PS_MODULE_DIR_ . 'okicustominfo/classes/OkiCustomInfoBlock.php';
require_once _PS_MODULE_DIR_ . 'okicustominfo/classes/OkiCustomInfoItem.php';

use PrestaShop\PrestaShop\Core\Form\ChoiceProvider\CategoriesChoiceProvider;
use HelperTreeCategories;

class AdminOkiCustomInfoAddItemController extends ModuleAdminController
{
    public function __construct()
    {
        parent::__construct();
        $this->bootstrap = true;
    }

    public function initContent()
    {
        parent::initContent();

        $id_block = Tools::getValue('id_block');

        if (!$id_block) {
            $this->errors[] = $this->l('ID InfoBlock manquant.');
            return;
        }

        $block = new OkiCustomInfoBlock($id_block);
        if (!Validate::isLoadedObject($block)) {
            $this->errors[] = $this->l('InfoBlock invalide.');
            return;
        }

        $fields = json_decode($block->properties, true);

        // echo '<pre>'; print_r($fields); echo '</pre>';
        // die();

        $categoryTreeHtml = $this->getCategoryTreeHtml();
        $products = $this->getProducts();

        $this->context->smarty->assign([
            'block_name' => $block->name,
            'fields' => $fields,
            'categories' => $categoryTreeHtml,
            'id_block' => $id_block,
            'products' => $products
        ]);

        $this->addJS(_MODULE_DIR_ . 'okicustominfo/views/js/back.js');
        $this->addCSS(_MODULE_DIR_ . 'okicustominfo/views/css/back.css');

        $this->context->smarty->assign('template_dir', _PS_MODULE_DIR_ . 'okicustominfo/views/templates/admin/');
        $this->setTemplate('add_item.tpl');
    }

    public function getCategoryTreeHtml()
    {
        $tree = new HelperTreeCategories('categories-tree');
        $tree->setRootCategory(2);
        $tree->setUseCheckBox(true);
        $tree->setUseSearch(true);
        $tree->setInputName('item[categories]');

        return $tree->render();
    }

    public function postProcess()
    {
        if (Tools::isSubmit('submit_add_item')) {
            $id_block = (int)Tools::getValue('id_block');
            $fields = Tools::getValue('item'); // Get regular form fields
            $fieldValues = []; // Array to store final values
            $fromItems = Tools::getValue('from_items'); // Check if we add item from items page
            
            if (!$id_block || empty($fields)) {
                $this->errors[] = $this->l('Données invalides.');
                return;
            }
            
            foreach ($fields as $field => $value) {
                // echo '<pre>'; print_r($value); echo '</pre>';
                $fieldValues[$field] = isset($value) ? (is_array($value) ? implode(',', $value) : $value) : '';
            }

            // Handle image upload
            if (isset($_FILES['item']['name']['image']) && !empty($_FILES['item']['name']['image'])) {
                $imageDir = _PS_MODULE_DIR_ . 'okicustominfo/views/img/';
                if (!file_exists($imageDir)) {
                    mkdir($imageDir, 0775, true);
                }

                $imageName = uniqid() . '_' . basename($_FILES['item']['name']['image']);
                $imagePath = $imageDir . $imageName;

                if (move_uploaded_file($_FILES['item']['tmp_name']['image'], $imagePath)) {
                    $fieldValues['image'] = 'modules/okicustominfo/views/img/' . $imageName;
                } else {
                    $this->errors[] = $this->l('Échec du téléchargement de l\'image.');
                }
            }

            // Insert the item into the corresponding table
            $tableName = _DB_PREFIX_ . 'okicustominfo_items_' . $id_block;

            // Prepare the fields to store
            $columns = [];
            $values = [];
            
            foreach ($fieldValues as $field => $value) {
                $columns[] = pSQL($field);
                $values[] = "'" . pSQL($value, true) . "'";
            }

            $sql = "INSERT INTO `$tableName` (`id_block`, " . implode(', ', $columns) . ", `date_created`) 
                VALUES ($id_block, " . implode(', ', $values) . ", NOW())";

            if (Db::getInstance()->execute($sql)) {
                $this->confirmations[] = $this->l('Item added successfully.');

                if ($fromItems === "Y" && $id_block) {
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminOkiCustomInfoItems') . '&id_block=' . (int)$id_block);
                } else {
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminOkiCustomInfo'));
                }
            } else {
                $this->errors[] = $this->l('Échec de l\'ajout de l\'élément.');
            }
        }
    }

    public function getProducts() {
        $id_lang = (int) $this->context->language->id;

        $products = Product::getProducts(
            $id_lang,
            0,
            1000, 
            'name',
            'asc'
        );

        $result = [];
        $categories = [5, 7, 9];
        foreach ($products as $product) {
            // echo '<pre>'; print_r($product); echo '</pre>';
            if (in_array($product['id_category_default'], $categories)) {
                $result[] = [
                    'id' => $product['id_product'],
                    'name' => $product['name']
                ];
            }
        }

        return $result;
    }
}

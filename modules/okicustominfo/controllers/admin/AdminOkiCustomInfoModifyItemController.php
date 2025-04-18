<?php
require_once _PS_MODULE_DIR_ . 'okicustominfo/classes/OkiCustomInfoBlock.php';
require_once _PS_MODULE_DIR_ . 'okicustominfo/classes/OkiCustomInfoItem.php';

use PrestaShop\PrestaShop\Core\Form\ChoiceProvider\CategoriesChoiceProvider;
use HelperTreeCategories;
use PrestaShop\PrestaShop\Core\Domain\Category\Query\GetCategoriesTree;

class AdminOkiCustomInfoModifyItemController extends ModuleAdminController
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
        $id_item = Tools::getValue('id_item');

        if (!$id_block) {
            $this->errors[] = $this->l('ID InfoBlock manquant.');
            return;
        }

        $block = new OkiCustomInfoBlock($id_block);
        if (!Validate::isLoadedObject($block)) {
            $this->errors[] = $this->l('Invalid InfoBlock.');
            return;
        }

        $fields = json_decode($block->properties, true);

        $itemData = [];
        // Fetch the existing item data
        $sql = 'SELECT * FROM ' . _DB_PREFIX_ . 'okicustominfo_items_' . (int) $id_block . ' WHERE id_item = ' . (int) $id_item;
        $itemData = Db::getInstance()->getRow($sql);

        // echo '<pre>'; print_r($itemData); echo '</pre>';
        // die();

        $selectedCategories = isset($itemData['categories']) ? explode(',', $itemData['categories']) : [];

        $this->context->smarty->assign([
            'block_name' => $block->name,
            'itemData' => $itemData,
            'categories' => $this->getCategoryTreeHtml($selectedCategories),
            'id_block' => $id_block,
        ]);

        $this->addJS(_MODULE_DIR_ . 'okicustominfo/views/js/back.js');
        $this->addCSS(_MODULE_DIR_ . 'okicustominfo/views/css/back.css');

        $this->context->smarty->assign('template_dir', _PS_MODULE_DIR_ . 'okicustominfo/views/templates/admin/');
        $this->setTemplate('modify_item.tpl');
    }

    public function getCategoryTreeHtml($selectedCategories = [])
    {
        $tree = new HelperTreeCategories('categories-tree');
        $tree->setRootCategory(2);
        $tree->setUseCheckBox(true);
        $tree->setUseSearch(true);
        $tree->setSelectedCategories($selectedCategories);
        $tree->setInputName('item[categories]');

        return $tree->render();
    }

    public function postProcess()
    {
        if (Tools::isSubmit('submit_modify_item')) {
            $id_item = (int) Tools::getValue('id_item');
            $id_block = (int) Tools::getValue('id_block');

            if (!$id_item || !$id_block) {
                $this->errors[] = $this->l('ID d\'élément ou de bloc non valide.');
                return;
            }

            $tableNameShort = 'okicustominfo_items_' . $id_block;
            
            $updateData = [];
            foreach ($_POST as $key => $value) {
                if (!in_array($key, ['submit_modify_item', 'id_item', 'id_block'])) {
                    // print_r($value);
                    
                    if (isset($value['categories']) && is_array($value['categories'])) {
                        // If categories is an array, implode and sanitize it
                        $updateData['categories'] = pSQL(implode(',', $value['categories']), true);
                    } else {
                        // For other fields, sanitize the value
                        $updateData[$key] = pSQL($value, true);
                    }
                }
            }

            // echo '<pre>'; print_r($updateData);echo '</pre>';
            // Handle image upload
            if (isset($_FILES['image']) && !empty($_FILES['image'])) {
                $imageDir = _PS_MODULE_DIR_ . 'okicustominfo/views/img/';
                if (!file_exists($imageDir)) {
                    mkdir($imageDir, 0775, true);
                }

                $imageName = uniqid() . '_' . basename($_FILES['image']['name']);
                $imagePath = $imageDir . $imageName;

                if (move_uploaded_file($_FILES['image']['tmp_name'], $imagePath)) {
                    $updateData['image'] = 'modules/okicustominfo/views/img/' . $imageName;
                } else {
                    $this->errors[] = $this->l('Échec du téléchargement de l\'image.');
                }
            }

            if ($id_item) {
                // var_dump($updateData);
                // die();
                Db::getInstance()->update($tableNameShort, $updateData, 'id_item = ' . (int)$id_item);
                
                $this->confirmations[] = $this->l('L\'élément mis à jour avec succès.');
            } else {
                $this->errors[] = $this->l('Aucun champ valide à mettre à jour.');
            }

            Tools::redirectAdmin($this->context->link->getAdminLink('AdminOkiCustomInfoItems') . '&id_block=' . $id_block);
        }
    }
}

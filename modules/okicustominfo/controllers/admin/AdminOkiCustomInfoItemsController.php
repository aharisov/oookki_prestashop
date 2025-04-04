<?php
require_once _PS_MODULE_DIR_ . 'okicustominfo/classes/OkiCustomInfoItem.php';
require_once _PS_MODULE_DIR_ . 'okicustominfo/classes/OkiCustomInfoBlock.php';

class AdminOkiCustomInfoItemsController extends ModuleAdminController
{
    public function __construct()
    {
        $this->table = 'okicustominfo_items';
        $this->className = 'OkiCustomInfoItem';
        $this->identifier = 'id_item';
        $this->lang = false;
        $this->bootstrap = true;

        parent::__construct();
    }

    public function initContent()
    {
        parent::initContent();
        $id_block = (int)Tools::getValue('id_block');
        
        if (!$id_block) {
            $this->errors[] = $this->l('ID InfoBlock non valide.');
            return;
        }

        $block = new OkiCustomInfoBlock($id_block);
        if (!Validate::isLoadedObject($block)) {
            $this->errors[] = $this->l('InfoBlock non trouvé.');
            return;
        }

        $fields = json_decode($block->properties, true);
        $tableHeaders = array_slice($fields['name'], 0, 5);
        
        $items = Db::getInstance()->executeS('
            SELECT * FROM ' . _DB_PREFIX_ . 'okicustominfo_items_' . (int)$id_block . '
            ORDER BY position ASC
        ');

        $this->context->smarty->assign([
            'id_block' => $id_block,
            'items' => $items,
            'tableHeaders' => $tableHeaders
        ]);

        $sql = 'SELECT name FROM ' . _DB_PREFIX_ . 'okicustominfo_blocks WHERE id_block = ' . (int)$id_block;
        $infoBlock = Db::getInstance()->getRow($sql);
        
        // Pass InfoBlock name to Smarty
        $this->context->smarty->assign('infoBlockName', $infoBlock['name']);

        // $this->addJS('<script src="https://cdn.jsdelivr.net/npm/jquery-sortablejs@latest/jquery-sortable.js"></script>');
        $this->addJS(_MODULE_DIR_ . 'okicustominfo/views/js/back.js');
        $this->addCSS(_MODULE_DIR_ . 'okicustominfo/views/css/back.css');
        
        $this->setTemplate('items_list.tpl');
    }

    public function ajaxProcessToggleStatus()
    {
        $id_item = (int)Tools::getValue('id_item');
        $id_block = (int)Tools::getValue('id_block');

        if (!$id_item || !$id_block) {
            die(json_encode(['error' => true, 'message' => $this->l('ID d\'élément ou de bloc non valide.')]));
        }

        if (OkiCustomInfoItem::changeStatus($id_item, $id_block)) {
            die(json_encode(['success' => true, 'message' => $this->l('Statut mis à jour avec succès.')]));
        } else {
            die(json_encode(['error' => true, 'message' => $this->l('Échec de la mise à jour du statut.')]));
        }
    }

    public function ajaxProcessDeleteItem()
    {
        $id_item = (int)Tools::getValue('id_item');
        $id_block = (int)Tools::getValue('id_block');

        if ($id_item && $id_block) {
            $table = _DB_PREFIX_ . 'okicustominfo_items_' . (int)$id_block;
            $success = Db::getInstance()->execute("DELETE FROM $table WHERE id_item = $id_item");

            die(json_encode(['success' => $success]));
        }
        die(json_encode(['success' => false]));
    }

    public function ajaxProcessUpdateItemPositions()
    {
        $positions = Tools::getValue('positions');
        
        if (!$positions) {
            die(json_encode(['success' => false, 'message' => 'No positions received']));
        }

        $positions = json_decode($positions, true);
        
        foreach ($positions as $item) {
            $id_item = (int) $item['id'];
            $position = (int) $item['position'];
    
            // Update item position in the database
            Db::getInstance()->update(
                'okicustominfo_items_' . (int)Tools::getValue('id_block'),
                ['position' => $position],
                'id_item = ' . (int)$id_item
            );
        }

        die(json_encode(['success' => true]));
    }

}

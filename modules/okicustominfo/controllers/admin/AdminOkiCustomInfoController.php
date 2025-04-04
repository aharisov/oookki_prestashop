<?php
require_once _PS_MODULE_DIR_ . 'okicustominfo/classes/OkiCustomInfoBlock.php';

class AdminOkiCustomInfoController extends ModuleAdminController
{
    public function __construct()
    {
        $this->table = 'okicustominfo_blocks';
        $this->className = 'OkiCustomInfoBlock';
        $this->identifier = 'id_block';
        $this->lang = false;
        $this->bootstrap = true;

        parent::__construct();

        $this->fields_list = [
            'id_block' => ['title' => $this->l('ID'), 'align' => 'center'],
            'name' => ['title' => $this->l('Type')],
            'title' => ['title' => $this->l('Titre')],
            'date_created' => ['title' => $this->l('Créé à')],
            'add_item' => [
                'title' => $this->l('Actions'),
                'callback' => 'renderAddItemButton',
                'align' => 'center',
                'orderby' => false,
                'search' => false,
            ],
        ];

        $this->addRowAction('edit');
        $this->addRowAction('delete');
    }

    public function getList($id_lang, $order_by = null, $order_way = null, $start = 0, $limit = null, $id_lang_shop = false)
    {
        parent::getList($id_lang, $order_by, $order_way, $start, $limit, $id_lang_shop);

        // Inject "Add Item" button in each row
        foreach ($this->_list as &$block) {
            $block['add_item'] = $this->renderAddItemButton(null, $block);
        }
    }

    public function renderAddItemButton($value, $row)
    {
        if (!isset($row['id_block'])) {
            return '--'; // If no block ID, return placeholder
        }

        $id_block = (int)$row['id_block'];
        $addItemUrl = $this->context->link->getAdminLink('AdminOkiCustomInfoAddItem') . '&id_block=' . $id_block;
        $viewItemsUrl = $this->context->link->getAdminLink('AdminOkiCustomInfoItems') . '&id_block=' . $id_block;

        $viewButton = '';

        if ($this->doesItemsTableExist($id_block)) {
            $itemCount = $this->getItemCount($id_block);
            if ($itemCount > 0) {
                $viewButton = '<a href="' . $viewItemsUrl . '" class="btn btn-primary btn-sm">' . $this->l('Voir les éléments') . ' (' . $itemCount . ')</a>';
            }
        }

        return '<a href="' . $addItemUrl . '" class="btn btn-success btn-sm">' . $this->l('Ajouter un élément') . '</a> ' . $viewButton;
    }

    /**
     * Check if the items table exists for a given InfoBlock.
     */
    private function doesItemsTableExist($id_block)
    {
        $tableName = _DB_PREFIX_ . 'okicustominfo_items_' . (int)$id_block;
        $sql = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '" . pSQL($tableName) . "'";
        return (bool)Db::getInstance()->getValue($sql);
    }

    /**
     * Get the count of items in the given InfoBlock's table.
     */
    private function getItemCount($id_block)
    {
        $tableName = _DB_PREFIX_ . 'okicustominfo_items_' . (int)$id_block;
        $sql = "SELECT COUNT(*) FROM `$tableName`";
        return (int)Db::getInstance()->getValue($sql);
    }

    public function renderForm()
    {
        $id_block = Tools::getValue('id_block');
        $block = new OkiCustomInfoBlock($id_block);

        // Retrieve saved fields
        $fields = [];
        if (Validate::isLoadedObject($block) && !empty($block->properties)) {
            $fields = json_decode($block->properties, true);
        }

        // echo '<pre>'; print_r($fields); echo '</pre>';
        // die();

        // Build HTML for dynamic fields
        $dynamicFieldsHtml = '<div id="dynamic-fields-container" class="mb-2">';

        if (!empty($fields['name'])) {
            foreach ($fields['name'] as $index => $name) {
                $type = $fields['type'][$index] ?? 'VARCHAR(255)'; // Default type if missing
                $dynamicFieldsHtml .= '
                    <div class="dynamic-field d-flex">
                        <input type="text" name="fields[name][]" value="' . htmlspecialchars($name) . '" placeholder="' . $this->l('Field Name') . '" />
                        <select name="fields[type][]">
                            <option value="VARCHAR(255)" ' . ($type == 'VARCHAR(255)' ? 'selected' : '') . '>Small Text</option>
                            <option value="TEXT" ' . ($type == 'TEXT' ? 'selected' : '') . '>Large Text</option>
                            <option value="INT" ' . ($type == 'INT' ? 'selected' : '') . '>Integer</option>
                            <option value="FLOAT" ' . ($type == 'FLOAT' ? 'selected' : '') . '>Decimal</option>
                            <option value="image" ' . ($type == 'image' ? 'selected' : '') . '>Image</option>
                        </select>
                        <button type="button" class="btn btn-danger delete-field">Delete</button>
                    </div>';
            }
        } else {
            $dynamicFieldsHtml .= '
                    <div class="dynamic-field d-flex">
                        <input type="text" name="fields[name][]" value="" placeholder="" />
                        <select name="fields[type][]">
                            <option value="VARCHAR(255)">Small Text</option>
                            <option value="TEXT">Large Text</option>
                            <option value="INT">Integer</option>
                            <option value="FLOAT">Decimal</option>
                            <option value="image">Image</option>
                        </select>
                    </div>';
        }

        $dynamicFieldsHtml .= '</div>
        <button type="button" id="add-field" class="btn btn-primary">' . $this->l('Add Field') . '</button>';

        // Define the form for creating or editing an InfoBlock
        $this->fields_form = [
            'legend' => ['title' => $this->l('Créer/Modifier l\'InfoBlock')],
            'input' => [
                [
                    'type' => 'text',
                    'label' => $this->l('Titre de l\'InfoBlock'),
                    'name' => 'name',
                    'required' => true,
                ],
                [
                    'type' => 'text',
                    'label' => $this->l('Titre pour afficher dans une section'),
                    'name' => 'title',
                    'required' => true,
                ],
                [
                    'type' => 'text',
                    'label' => $this->l('Propriétés (JSON Format)'),
                    'name' => 'properties',
                    'autoload_rte' => true,
                    'readonly' => true
                ],
                [
                    'type' => 'html',
                    'label' => $this->l('Ajouter des champs'),
                    'name' => 'dynamic_fields',
                    'html_content' => $dynamicFieldsHtml,
                ],
            ],
            'submit' => ['title' => $this->l('Sauvegarder')]
        ];

        // Add the JavaScript for dynamic field addition
        $this->addJS(_MODULE_DIR_ . 'okicustominfo/views/js/back.js');
        $this->addCSS(_MODULE_DIR_ . 'okicustominfo/views/css/back.css');

        return parent::renderForm();
    }

    public function postProcess()
    {
        if (Tools::isSubmit('submitAdd'.$this->table)) {
            $id_block = Tools::getValue('id_block');

            // Capture the dynamic fields
            $fields = Tools::getValue('fields');
            // Store fields as a JSON object
            $properties = json_encode($fields);
            // Assign JSON to properties field
            $_POST['properties'] = $properties;

            if ($id_block) {
                if (!$this->doesItemsTableExist($id_block)) {
                    // Modify infoblock
                    $block = new OkiCustomInfoBlock($id_block);
                    if (Validate::isLoadedObject($block)) {
                        $block->name = Tools::getValue('name');
                        $block->title = Tools::getValue('title');
                        $block->properties = $properties;
                        $block->date_updated = date('Y-m-d H:i:s'); 
                        $block->update();
                        $block->rebuildItemsTable();
                        $this->confirmations[] = $this->l('InfoBlock mis à jour avec succès.');
                    }
                } else {
                    $itemCount = $this->getItemCount($id_block);
                    if ($itemCount > 0) {
                        $this->errors[] = $this->l('La modification n\'est pas autorisée car il existe des éléments dans cet InfoBlock.');
                    } else {
                        // Modify infoblock
                        $block = new OkiCustomInfoBlock($id_block);
                        if (Validate::isLoadedObject($block)) {
                            $block->name = Tools::getValue('name');
                            $block->title = Tools::getValue('title');
                            $block->properties = $properties;
                            $block->date_updated = date('Y-m-d H:i:s'); 
                            $block->update();
                            $block->rebuildItemsTable();
                            $this->confirmations[] = $this->l('InfoBlock mis à jour avec succès.');
                        }
                    }
                }
            } else {
                $_POST['date_created'] = date('Y-m-d H:i:s'); 
            }
        }

        parent::postProcess();
    }
}

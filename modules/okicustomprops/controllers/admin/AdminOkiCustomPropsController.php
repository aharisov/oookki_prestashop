<?php

require_once _PS_MODULE_DIR_ . 'okicustomprops/classes/OkiCustomProp.php';

class AdminOkiCustomPropsController extends ModuleAdminController
{
    public $id_group;
    public $groupName;

    public function __construct()
    {
        $this->bootstrap = true;
        $this->table = 'oki_properties';
        $this->className = 'OkiCustomProp'; 
        $this->lang = false;
        $this->identifier = 'id_property';
        $this->id_group = (int)Tools::getValue('id_group');
        
        // filter props by group
        $this->_where = 'AND a.id_group = ' . (int)$this->id_group;
        $this->groupName = $this->getGroupName($this->id_group);
        
        parent::__construct();

        $this->toolbar_btn['new-module'] = array(
            'href' => $this->context->link->getAdminLink('AdminOkiCustomProps').'&addoki_properties&id_group='.$this->id_group,
            'desc' => $this->trans('Add prop'),
            'icon' => 'process'
        );

        $this->fields_list = [
            'id_property' => ['title' => $this->trans('ID'), 'align' => 'center', 'class' => 'fixed-width-xs'],
            'name' => ['title' => $this->trans('Nom de propriété')],
            'input_type' => ['title' => $this->trans('Type')],
        ];

        $this->actions = ['edit', 'delete'];

        $this->page_header_toolbar_title = $this->trans('Gestion de propriétés');

        if ($this->groupName) {
            $this->toolbar_title = $this->trans('Propriétés du groupe ') . $this->groupName;  
        }
    }

    public function renderForm()
    {
        $this->fields_form = [
            'legend' => [
                'title' => $this->trans('Ajouter une propriété'),
            ],
            'input' => [
                [
                    'type' => 'text',
                    'label' => $this->trans('Group ID'),
                    'name' => 'id_group',
                ],
                [
                    'type' => 'text',
                    'label' => $this->trans('Nom'),
                    'name' => 'name',
                    'required' => true,
                ],
                [
                    'type' => 'select',
                    'label' => $this->trans('Type'),
                    'name' => 'input_type',
                    'options' => [
                        'query' => [
                            ['id' => 'text', 'name' => $this->trans('Text')],
                            ['id' => 'select', 'name' => $this->trans('Select')],
                            ['id' => 'checkbox', 'name' => $this->trans('Checkbox')],
                        ],
                        'id' => 'id',
                        'name' => 'name',
                    ]
                ]
            ],
            'submit' => ['title' => $this->trans('Enregistrer')]
        ];

        return parent::renderForm();
    }

    public function postProcess()
    {
        $idGroup = Tools::getValue('id_group');
        parent::postProcess();

        if (Tools::isSubmit('submitAddoki_properties')) {
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminOkiCustomProps') . '&id_group=' . (int)$this->id_group);
        }

        if (Tools::isSubmit('delete' . $this->table)) {
            $_GET['id_group'] = $idGroup;
        }
    }

    public function renderList()
    {
        $output = parent::renderList();

        // Add the "Return" button to the list page
        $returnUrl = $this->context->link->getAdminLink('AdminOkiCustomPropsGroups');
        $output .= '<a href="' . $returnUrl . '" class="btn btn-default">' . $this->trans('Retourner') . '</a>';

        return $output;
    }

    protected function getGroupName($id_group)
    {
        $sql = 'SELECT `name` FROM `' . _DB_PREFIX_ . 'oki_property_groups` WHERE `id_group` = ' . (int)$id_group;
        return Db::getInstance()->getValue($sql);
    }

    public function setMedia($isNewTheme = false)
    {
        parent::setMedia($isNewTheme);
        $this->addCSS(_MODULE_DIR_ . 'okicustomprops/views/css/admin.css');
    }
}

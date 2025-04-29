<?php

require_once _PS_MODULE_DIR_ . 'okicustomprops/classes/OkiCustomPropsGroup.php';

class AdminOkiCustomPropsGroupsController extends ModuleAdminController
{
    public function __construct()
    {
        $this->bootstrap = true;
        $this->table = 'oki_property_groups';
        $this->className = 'OkiCustomPropsGroup';
        $this->lang = false;
        $this->identifier = 'id_group';
        
        parent::__construct();

        $id_lang = (int)Context::getContext()->language->id;

        $this->_select = 'cl.name AS category_name';
        $this->_join = 'LEFT JOIN '._DB_PREFIX_.'category_lang cl ON (cl.id_category = a.id_category AND cl.id_lang = '.$id_lang.')';

        $this->fields_list = [
            'id_group' => ['title' => $this->trans('ID'), 'align' => 'center', 'class' => 'fixed-width-xs'],
            'name' => ['title' => $this->trans('Nom du groupe')],
            'category_name' => ['title' => $this->trans('Catégorie')],
            'id_category' => ['title' => $this->trans('ID de la catégorie')],
            'add_prop' => [
                'title' => '', 
                'callback' => 'renderAddPropButton',
                'search' => false, 
                'orderby' => false,
                'type' => 'html'
            ],
        ];

        $this->actions = ['edit', 'delete'];

        $this->page_header_toolbar_btn['all_products']  = array(
            'href' => $this->context->link->getAdminLink('AdminOkiCustomPropsProducts'),
            'desc' => $this->trans('Gérer les produits'),
            'icon' => 'process-icon-edit'
        );

        $this->page_header_toolbar_title = $this->trans('Gestion de groupes');
        $this->toolbar_title = $this->trans('Groupes de caractéristiques');
    }

    public function getList($id_lang, $order_by = null, $order_way = null, $start = 0, $limit = null, $id_lang_shop = false)
    {
        parent::getList($id_lang, $order_by, $order_way, $start, $limit, $id_lang_shop);

        foreach ($this->_list as &$row) {
            $row['add_prop'] = $this->renderAddPropButton(null, $row);
        }
    }

    public function renderAddPropButton($value, $row)
    {
        if (!isset($row['id_group'])) {
            return '--';
        }

        $id_group = (int)$row['id_group'];

        $url = $this->context->link->getAdminLink('AdminOkiCustomProps') . '&id_group=' . $id_group;

        return '<a href="' . $url . '" class="btn btn-default btn-sm">
                    ' . $this->trans('Liste de propriétés') . '
                </a>';
    }

    public function renderForm()
    {
        $categories = Category::getSimpleCategories($this->context->language->id);
        $categoryOptions = [];

        foreach ($categories as $cat) {
            $categoryOptions[] = [
                'id' => $cat['id_category'],
                'name' => $cat['name']
            ];
        }

        $this->fields_form = [
            'legend' => ['title' => $this->trans('Property Group')],
            'input' => [
                [
                    'type' => 'text',
                    'label' => $this->trans('Group Name'),
                    'name' => 'name',
                    'required' => true
                ],
                [
                    'type' => 'select',
                    'label' => $this->trans('Linked Category'),
                    'name' => 'id_category',
                    'required' => true,
                    'options' => [
                        'query' => $categoryOptions,
                        'id' => 'id',
                        'name' => 'name'
                    ]
                ]
            ],
            'submit' => ['title' => $this->trans('Save')]
        ];

        return parent::renderForm();
    }

}

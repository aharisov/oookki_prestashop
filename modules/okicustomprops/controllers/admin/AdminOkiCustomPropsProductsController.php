<?php

class AdminOkiCustomPropsProductsController extends ModuleAdminController
{
    public function __construct()
    {
        $this->bootstrap = true;
        $this->table = 'product';
        $this->className = 'Product';
        $this->identifier = 'id_product';
        $this->lang = true;

        parent::__construct();

        $id_lang = (int)Context::getContext()->language->id;

        $this->_select = 'pl.name as product_name, cl.name as category_name, cl.id_category as category_id';
        $this->_join = '
            LEFT JOIN '._DB_PREFIX_.'product_lang pl ON (pl.id_product = a.id_product AND pl.id_lang = '.(int)$id_lang.')
            LEFT JOIN '._DB_PREFIX_.'category_lang cl ON (cl.id_category = a.id_category_default AND cl.id_lang = '.(int)$id_lang.')
        ';
        $this->_orderBy = 'cl!name';

        $this->fields_list = [
            'id_product' => ['title' => $this->trans('ID de produit'), 'class' => 'fixed-width-xs'],
            'category_name' => [
                'title' => $this->trans('Catégorie principale'),
                'filter_key' => 'cl!name',
                'orderby' => true,
            ],
            'category_id' => [
                'title' => $this->trans('ID de la catégorie'),
            ],
            'product_name' => [
                'title' => $this->trans('Nom du produit'),
                'filter_key' => 'pl!name'
            ],
            'fill_props' => [
                'title' => '', 
                'callback' => 'renderFillPropsLink',
                'search' => false, 
                'orderby' => false,
            ],
        ];

        $this->page_header_toolbar_title = $this->trans('Gestion de caractéristiques');
        $this->toolbar_title = $this->trans('Produits');

        
    }

    public function getList($id_lang, $order_by = null, $order_way = null, $start = 0, $limit = null, $id_lang_shop = false)
    {
        parent::getList($id_lang, $order_by, $order_way, $start, $limit, $id_lang_shop);

        foreach ($this->_list as &$row) {
            $row['fill_props'] = $this->renderFillPropsLink(null, $row);
        }
    }

    public function renderFillPropsLink($value, $row)
    {
        $id_product = (int)$row['id_product'];

        $url = $this->context->link->getAdminLink('AdminOkiCustomPropsFill') . '&id_product=' . $id_product;

        return '<a href="' . $url . '" class="btn btn-success btn-sm">
                    ' . $this->trans('Remplir de caractéristiques') . '
                </a>';
    }

    public function initPageHeaderToolbar()
    {
        $this->toolbar_btn = []; // removes buttons
        parent::initPageHeaderToolbar();
    }

    public function getRowUrl($row)
    {
        $id_product = (int)$row['id_product'];
        $token = Tools::getAdminTokenLite('AdminOkiCustomPropsFill');
        return 'index.php?controller=AdminOkiCustomPropsFill&id_product=' . $id_product . '&token=' . $token;
    }

    public function renderList()
    {
        $output = parent::renderList();

        $returnUrl = $this->context->link->getAdminLink('AdminOkiCustomPropsGroups');
        $output .= '<a href="' . $returnUrl . '" class="btn btn-default">' . $this->trans('Retourner aux groupes') . '</a>';

        return $output;
    }
}

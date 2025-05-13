<?php

require_once _PS_MODULE_DIR_ . 'okicustomprops/classes/OkiCustomPropsGroup.php';
require_once _PS_MODULE_DIR_ . 'okicustomprops/classes/OkiCustomProp.php';

class AdminOkiCustomPropsFillController extends ModuleAdminController
{
    protected $product;

    public function __construct()
    {
        $this->bootstrap = true;
        // $this->display = 'edit';

        parent::__construct();

        $this->page_header_toolbar_title = $this->trans('Remplir les caractéristiques');
    }

    public function initContent()
    {
        $id_product = (int)Tools::getValue('id_product');
        $this->product = new Product($id_product, false, $this->context->language->id);
        $id_category = (int)$this->product->id_category_default;

        if (!Validate::isLoadedObject($this->product)) {
            return parent::initContent(); // Show error or redirect
        }

        $groups = OkiCustomPropsGroup::getAllGroupsWithProps($this->product->id, $id_category);

        $returnUrl = $this->context->link->getAdminLink('AdminOkiCustomPropsProducts');

        $this->context->smarty->assign([
            'returnUrl' => $returnUrl,
            'return_button_text' => $this->trans('Retourner aux produits'),
            'product' => $this->product,
            'groups' => $groups,
            'form_action' => $this->context->link->getAdminLink('AdminOkiCustomPropsFill') . '&id_product=' . $id_product
        ]);

        $this->setTemplate('fill_props_form.tpl');

    }

    public function postProcess()
    {
        if (Tools::isSubmit('submitProps')) {
            $id_product = (int)Tools::getValue('id_product');
            $props = Tools::getAllValues();
            // $props = $_POST;
            // unset($props['controller'], $props['token'], $props['submitProps'], $props['controllerUri']);

            OkiCustomProp::saveProps($id_product, $props);

            $this->confirmations[] = $this->trans('Les caractéristiques sont enregistrées avec succès.', [], 'Modules.Okicustomprops.Admin');
        }
    }

    public function setMedia($isNewTheme = false)
    {
        parent::setMedia($isNewTheme);
        $this->addCSS(_MODULE_DIR_ . 'okicustomprops/views/css/admin.css');
    }
}

<?php

class OkimodalsPopupModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        parent::initContent();

        $type = Tools::getValue('type');
        $tpl = '';
        $assign = [];

        switch ($type) {
            case 'add_to_cart':
                $id_product = (int)Tools::getValue('id_product');
                $product = new Product($id_product, false, $this->context->language->id);
                $assign = ['product' => $product];
                $tpl = 'module:yourmodule/views/templates/front/modal-add-to-cart.tpl';
                break;

            case 'newsletter':
                $assign = ['title' => 'Thanks for signing up!'];
                $tpl = 'module:yourmodule/views/templates/front/modal-newsletter.tpl';
                break;

            case 'custom':
                $assign = ['message' => 'Custom message here'];
                $tpl = 'module:yourmodule/views/templates/front/modal-custom.tpl';
                break;

            default:
                $assign = ['message' => 'Default modal'];
                $tpl = 'module:yourmodule/views/templates/front/modal-default.tpl';
        }

        $this->context->smarty->assign($assign);
        $html = $this->module->fetch($tpl);

        header('Content-Type: application/json');
        die(json_encode(['modal' => $html]));
    }
}
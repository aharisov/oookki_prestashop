<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

class OkiModals extends Module
{
    public function __construct()
    {
        $this->name = 'okimodals';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'Alex Harisov';
        $this->need_instance = 0;
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Oki Custom Modals');
        $this->description = $this->l('Displays different modal popups.');
    }

    public function install()
    {
        return parent::install() &&
            $this->installRoutes();
    }

    public function uninstall()
    {
        return parent::uninstall();
    }

    private function installRoutes()
    {
        return (bool)Dispatcher::getInstance()->addRoute(
            'module-okimodals-popup',
            'module/okimodals/popup',
            [
                'module' => 'okimodals',
                'controller' => 'popup',
                'fc' => 'module',
            ]
        );
    }

    public function hookHeader()
    {
        $this->context->controller->registerJavascript(
            'modules-okimodals-popupjs',
            'modules/' . $this->name . '/views/js/popup.js',
            ['position' => 'bottom', 'priority' => 150]
        );
    }
}

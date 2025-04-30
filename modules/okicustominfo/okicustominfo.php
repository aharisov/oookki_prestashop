<?php

use PrestaShopBundle\Entity\Repository\TabRepository;
if (!defined('_PS_VERSION_')) {
    exit;
}

use PrestaShop\PrestaShop\Core\Module\WidgetInterface;
use PrestaShop\PrestaShop\Adapter\SymfonyContainer;

class OkiCustomInfo extends Module
{
    /** @var string */
    public $name;
    /** @var string */
    public $tab;
    /** @var string */
    public $version;
    /** @var string */
    public $author;
    /** @var bool */
    public $need_instance;
    /** @var bool */
    public $bootstrap;
    /** @var string */
    public $displayName;
    /** @var string */
    public $description;
    /** @var string */
    public $ps_versions_compliancy;
    
    public function __construct()
    {
        $this->name = 'okicustominfo';
        $this->tab = 'administration';
        $this->version = '1.0.0';
        $this->author = 'Alex Harisov';
        $this->need_instance = 0;
        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Oki Custom Info');
        $this->description = $this->l('Module for managing custom InfoBlocks and displaying them in the front office.');
        
        $this->ps_versions_compliancy = ['min' => '1.7', 'max' => _PS_VERSION_];
    }

    public function install()
    {
        if (parent::install()
            && $this->registerHook('displayBackOfficeHeader')
            && $this->registerHook('displayOkiCustomInfo')
            && $this->installDatabase()
            && $this->addAdminTab()
        ) {
            return true;
        }

        $this->_errors[] = $this->trans('There was an error during the installation.', [], 'Modules.Okicustominfo.Admin');

        return false;
    }

    public function uninstall()
    {
        if (parent::uninstall()
            && $this->uninstallDatabase()
            && $this->removeAdminTab()
        ) {
            return true;
        }

        $this->_errors[] = $this->trans('There was an error during the uninstallation. Please <a href="https://github.com/PrestaShop/PrestaShop/issues">open an issue</a> on the PrestaShop project.', [], 'Modules.Blockreassurance.Admin');

        return false;
    }

    private function installDatabase()
    {
        $sql = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'okicustominfo_blocks` (
            `id_block` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            `name` VARCHAR(255) NOT NULL,
            `title` VARCHAR(255) NOT NULL,
            `properties` JSON NOT NULL,
            `date_created` DATETIME NOT NULL,
            `date_updated` DATETIME NOT NULL
        ) ENGINE=' . _MYSQL_ENGINE_ . ' DEFAULT CHARSET=utf8;';

        return Db::getInstance()->execute($sql);
    }

    private function uninstallDatabase()
    {
        $sql = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'okicustominfo_blocks`;';
        return Db::getInstance()->execute($sql);
    }

    private function addAdminTab()
    {
        $tab = new Tab();
        $tab->active = 1;
        $tab->class_name = 'AdminOkiCustomInfo';
        $tab->id_parent = (int) SymfonyContainer::getInstance()->get('prestashop.core.admin.tab.repository')->findOneIdByClassName('IMPROVE'); 
        $tab->module = $this->name;
        $tab->name = [];
        foreach (Language::getLanguages() as $lang) {
            $tab->name[$lang['id_lang']] = 'Oki Custom Info';
        }
        return $tab->add();
    }

    private function removeAdminTab()
    {
        $id_tab = (int) SymfonyContainer::getInstance()->get('prestashop.core.admin.tab.repository')->findOneIdByClassName('AdminOkiCustomInfo');
        if ($id_tab) {
            $tab = new Tab($id_tab);
            return $tab->delete();
        }
        return true;
    }

    /**
    * Add the CSS & JavaScript files you want to be loaded in the BO.
    */
    public function hookDisplayBackOfficeHeader()
    {
        if (Tools::getValue('configure') == $this->name) {
            $this->context->controller->registerJavascript(
                'okicustominfo',
                $this->_path . 'views/js/back.js'
            );
            $this->context->controller->registerStylesheet(
                'okicustominfo',
                $this->_path . 'views/css/back.css'
            );
        }
    }

    public function hookDisplayOkiCustomInfo($params)
    {
        if (!isset($params['id_block']) || empty($params['id_block'])) {
            return 'No InfoBlock ID provided';
        }

        $id_block = (int) $params['id_block'];
        $template = isset($params['template']) ? preg_replace('/[^a-zA-Z0-9_-]+/', '', $params['template']) : '';

        if (!empty($params['id_category'])) {
            $category = $params['id_category'];
        } else {
            $category = "";
        }

        if (!empty($params['id_product'])) {
            $product = $params['id_product'];
        } else {
            $product = "";
        }

        // Fetch InfoBlock info
        $sql = 'SELECT * FROM `' . _DB_PREFIX_ . 'okicustominfo_blocks` 
        WHERE `id_block` = ' . $id_block;
        $infoBlock = Db::getInstance()->executeS($sql);

        // Fetch items related to this InfoBlock
        if ($product) {
            $sql = 'SELECT * FROM `' . _DB_PREFIX_ . 'okicustominfo_items_' . (int)$id_block . '` 
            WHERE `active` = 1 AND `product_id` = ' . $product . '
            ORDER BY `position` ASC';
            $items = Db::getInstance()->executeS($sql);
        } else {
            $sql = 'SELECT * FROM `' . _DB_PREFIX_ . 'okicustominfo_items_' . (int)$id_block . '` 
            WHERE `active` = 1 
            ORDER BY `position` ASC';
            $items = Db::getInstance()->executeS($sql);
        }

        // Determine template file: Use provided template or default
        $templateFile = !empty($template) ? 'views/templates/front/' . $template . '.tpl' : 'views/templates/front/base.tpl';

        // Assign variables to Smarty
        $this->context->smarty->assign([
            'infoblock' => $infoBlock[0],
            'category' => $category,
            'items' => $items,
            'module_dir' => _MODULE_DIR_ . $this->name
        ]);

        return $this->display(__FILE__, $templateFile);
    }

}

<?php

if (!defined('_PS_VERSION_')) {
    exit;
}

class OkiCustomProps extends Module
{
    public function __construct()
    {
        $this->name = 'okicustomprops';
        $this->tab = 'catalog';
        $this->version = '1.0.0';
        $this->author = 'Alex Harisov';
        $this->need_instance = 0;

        parent::__construct();

        $this->displayName = $this->l('Oki Custom Product Properties');
        $this->description = $this->l('Ajoutez des propriétés personnalisées aux produits, regroupées par catégorie.');
    }

    public function install()
    {
        return parent::install()
            && $this->installTab()
            && $this->installDb();
    }

    public function uninstall()
    {
        return parent::uninstall()
            && $this->uninstallTab()
            && $this->uninstallDb();
    }

    private function installTab()
    {
        $tab = new Tab();
        $tab->active = 1;
        $tab->name = [];

        foreach (Language::getLanguages(true) as $lang) {
            $tab->name[$lang['id_lang']] = 'Caractéristiques personnalisées';
        }

        $tab->class_name = 'AdminOkiCustomPropsGroups';
        $tab->id_parent = Tab::getIdFromClassName('AdminCatalog');
        $tab->module = $this->name;
        return $tab->add();
    }

    private function uninstallTab()
    {
        $id_tab = Tab::getIdFromClassName('AdminOkiCustomPropsGroups');
        if ($id_tab) {
            $tab = new Tab($id_tab);
            return $tab->delete();
        }
        return true;
    }

    private function installDb()
    {
        $sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'oki_property_groups` (
            `id_group` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            `name` VARCHAR(255) NOT NULL,
            `id_category` INT UNSIGNED NOT NULL
        ) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8;';
        
        $sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'oki_properties` (
            `id_property` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            `id_group` INT UNSIGNED NOT NULL,
            `name` VARCHAR(255) NOT NULL,
            `input_type` ENUM("text", "select", "checkbox") NOT NULL DEFAULT "text"
        ) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8;';
        
        $sql[] = 'CREATE TABLE IF NOT EXISTS `'._DB_PREFIX_.'oki_property_values` (
            `id_product` INT UNSIGNED NOT NULL,
            `id_property` INT UNSIGNED NOT NULL,
            `value` TEXT,
            PRIMARY KEY (`id_product`, `id_property`)
        ) ENGINE='._MYSQL_ENGINE_.' DEFAULT CHARSET=utf8;';
        
        // Exécution des requêtes
        foreach ($sql as $query) {
            if (!Db::getInstance()->execute($query)) {
                return false;
            }
        }

        return true;
    }

    private function uninstallDb()
    {
        $sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'oki_property_groups`;';
        $sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'oki_properties`;';
        $sql[] = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'oki_property_values`;';

        // Exécution des requêtes
        foreach ($sql as $query) {
            if (!Db::getInstance()->execute($query)) {
                return false;
            }
        }

        return true;
    }
}

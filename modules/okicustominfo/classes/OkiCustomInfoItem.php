<?php

class OkiCustomInfoItem extends ObjectModel
{
    public $id_block;
    public $active;
    public $position;
    public $date_created;
    public $date_updated;

    public static $definition = [
        'primary' => 'id_item',
        'fields' => [
            'id_block' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedInt'],
            'active' => ['type' => self::TYPE_BOOL, 'validate' => 'isBool'],
            'position' => ['type' => self::TYPE_INT, 'validate' => 'isUnsignedInt'],
            'date_created' => ['type' => self::TYPE_DATE, 'validate' => 'isDate'],
            'date_updated' => ['type' => self::TYPE_DATE, 'validate' => 'isDate'],
        ]
    ];

    public function __construct($id_item = null, $id_block = null)
    {
        if ($id_block) {
            self::$definition['table'] = 'okicustominfo_items_' . (int)$id_block;
        }
        parent::__construct($id_item);
    }

    public function add($autoDate = true, $nullValues = false)
    {
        self::$definition['table'] = 'okicustominfo_items_' . (int)$this->id_block;
        return parent::add($autoDate, $nullValues);
    }

    public static function getItemsByBlock($id_block)
    {
        $tableName = _DB_PREFIX_ . 'okicustominfo_items_' . (int)$id_block;
        $sql = "SELECT * FROM `$tableName` WHERE `id_block` = " . (int)$id_block;
        return Db::getInstance()->executeS($sql);
    }

    public static function changeStatus($id_item, $id_block)
    {
        if (!$id_item || !$id_block) {
            return false;
        }

        $tableName = _DB_PREFIX_ . 'okicustominfo_items_' . (int)$id_block;
        
        $sql = "SELECT * FROM `$tableName` WHERE `id_item` = " . (int)$id_item;
        $itemData = Db::getInstance()->executeS($sql);

        $currentStatus = $itemData[0]["active"];

        if ($currentStatus === false) {
            return false; // L'élément n'existe pas
        }

        // Inverser le statut
        $newStatus = (int)!$currentStatus;

        return Db::getInstance()->execute(
            'UPDATE `' . $tableName . '` 
            SET active = ' . (int)$newStatus . ' 
            WHERE id_item = ' . (int)$id_item
        );
    }

}
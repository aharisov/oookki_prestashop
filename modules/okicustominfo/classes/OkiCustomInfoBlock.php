<?php

class OkiCustomInfoBlock extends ObjectModel
{
    public $id_block;
    public $name;
    public $title;
    public $properties;
    public $date_created;
    public $date_updated;

    public static $definition = [
        'table' => 'okicustominfo_blocks',
        'primary' => 'id_block',
        'fields' => [
            'name' => ['type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'required' => true],
            'title' => ['type' => self::TYPE_STRING, 'validate' => 'isCleanHtml', 'required' => true],
            'properties' => ['type' => self::TYPE_HTML, 'validate' => 'isCleanHtml'],
            'date_created' => ['type' => self::TYPE_DATE, 'validate' => 'isDate'],
            'date_updated' => ['type' => self::TYPE_DATE, 'validate' => 'isDate'],
        ],
    ];

    public function add($autoDate = true, $nullValues = false)
    {
        if (!parent::add($autoDate, $nullValues)) {
            return false;
        }

        return $this->createItemsTable();
    }

     /**
     * Creates the table for the InfoBlock's items.
     * This method will create a new table for the InfoBlock's dynamic fields.
     */
    public function createItemsTable()
    {
        $tableName = 'okicustominfo_items_' . (int)$this->id;

        $sql = "CREATE TABLE IF NOT EXISTS `" . _DB_PREFIX_ . $tableName . "` (
            `id_item` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            `id_block` INT UNSIGNED NOT NULL,
            `active` BOOLEAN,
            `position` INT(10) unsigned NOT NULL,
            `date_created` DATETIME DEFAULT CURRENT_TIMESTAMP,
            `date_updated` DATETIME NOT NULL
        ";
    
        // Add fields dynamically based on properties
        $fields = json_decode($this->properties, true);
        foreach ($fields['name'] as $index => $field) {
            if ($fields['type'][$index] == 'image') {
                $fieldType = 'VARCHAR(255)'; // For storing image paths/URLs
            } else {
                $fieldType = $fields['type'][$index];
            }

            $fieldName = strtolower(str_replace(' ', '_', $field));

            $sql .= ", `" . pSQL($fieldName) . "` " . $fieldType;
        }
    
        $sql .= ", INDEX (`id_block`) ) ENGINE=" . _MYSQL_ENGINE_ . " DEFAULT CHARSET=utf8;";

        return Db::getInstance()->execute($sql);
    }

    /**
     * Rebuilds the table based on the updated fields (from JSON).
     * Drops the existing table and recreates it with updated fields.
     */
    public function rebuildItemsTable()
    {
        // Generate the table name for this InfoBlock
        $tableName = 'okicustominfo_items_' . (int)$this->id;
        
        // Drop the existing table if it exists
        $sqlDropTable = "DROP TABLE IF EXISTS `" . _DB_PREFIX_ . $tableName . "`";
        Db::getInstance()->execute($sqlDropTable);

        // Recreate the table with the updated fields
        $this->createItemsTable();
    }
}

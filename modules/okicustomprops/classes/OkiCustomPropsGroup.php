<?php
class OkiCustomPropsGroup extends ObjectModel
{
    public $id_group;
    public $name;
    public $id_category;

    public static $definition = [
        'table' => 'oki_property_groups',
        'primary' => 'id_group',
        'fields' => [
            'name' => ['type' => self::TYPE_STRING, 'required' => true],
            'id_category' => ['type' => self::TYPE_INT, 'required' => true]
        ]
    ];

    public static function getAllGroupsWithProps($id_product = null, $id_category = null)
    {
        $groups = Db::getInstance()->executeS(
            'SELECT id_group, name
            FROM '._DB_PREFIX_.'oki_property_groups
            WHERE id_category = '.(int)$id_category .'
            ORDER BY id_group ASC'
        );

        $results = [];

        foreach ($groups as $group) {
            $props = Db::getInstance()->executeS(
                'SELECT p.id_property, p.name, p.input_type, v.value
                FROM '._DB_PREFIX_.'oki_properties p
                LEFT JOIN '._DB_PREFIX_.'oki_property_values v 
                    ON (v.id_property = p.id_property AND v.id_product = '.(int)$id_product.')
                WHERE p.id_group = '.(int)$group['id_group'].'
                ORDER BY p.id_property ASC'
            );

            $results[] = [
                'id_group' => $group['id_group'],
                'name' => $group['name'],
                'props' => $props
            ];
        }

        return $results;
    }


}

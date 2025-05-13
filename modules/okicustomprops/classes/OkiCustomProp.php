<?php

class OkiCustomProp extends ObjectModel
{
    public $id_property;
    public $id_group;
    public $name;
    public $input_type;

    public static $definition = [
        'table' => 'oki_properties',
        'primary' => 'id_property',
        'fields' => [
            'id_group' => ['type' => self::TYPE_INT, 'required' => true],
            'name' => ['type' => self::TYPE_STRING, 'required' => true],
            'input_type' => ['type' => self::TYPE_STRING, 'required' => true],
        ],
    ];

    public static function saveProps($id_product, $props)
    {
        // print_r($props);
        foreach ($props as $key => $value) {
            // Skip values that are not related to a prop (e.g., id_product, submitProps, etc.)
            if (strpos($key, 'prop_') === false) {
                continue;
            }

            // Extract the property ID from the key (e.g., 'prop_1' -> 1)
            $id_prop = (int)str_replace('prop_', '', $key);

            // Clean and sanitize the value before saving
            // $value = pSQL($value); 

            // Check if the property already exists for this product
            $existingProp = Db::getInstance()->getRow('
                SELECT id_property
                FROM ' . _DB_PREFIX_ . 'oki_property_values
                WHERE id_product = ' . (int)$id_product . '
                AND id_property = ' . (int)$id_prop
            );

            // If the property exists, update it
            if ($existingProp) {
                Db::getInstance()->update(
                    'oki_property_values',
                    ['value' => pSQL($value)],
                    'id_property = ' . (int)$existingProp['id_property']
                );
            } else {
                // Otherwise, insert a new record for this property
                Db::getInstance()->insert(
                    'oki_property_values',
                    [
                        'id_product' => (int)$id_product,
                        'id_property' => (int)$id_prop,
                        'value' => pSQL($value)
                    ]
                );
            }
        }

        return true;
    }

    public static function getProductProps($id_product, $id_category)
    {
        $groups = Db::getInstance()->executeS(
            'SELECT id_group, name
            FROM '._DB_PREFIX_.'oki_property_groups
            WHERE id_category = '.(int)$id_category .'
            ORDER BY id_group ASC'
        );
        // echo '<pre>'; print_r($groups); echo '</pre>';

        $result = [];

        foreach ($groups as $group) {
            $props = Db::getInstance()->executeS(
                'SELECT p.id_property, p.name, v.value
                FROM '._DB_PREFIX_.'oki_properties p
                LEFT JOIN '._DB_PREFIX_.'oki_property_values v 
                    ON (v.id_property = p.id_property AND v.id_product = '.(int)$id_product.')
                WHERE p.id_group = '.(int)$group['id_group'].'
                ORDER BY p.id_property ASC'
            );

            $result[] = [
                'id_group' => $group['id_group'],
                'name' => $group['name'],
                'props' => $props
            ];
        }

        // echo '<pre>'; print_r($result); echo '</pre>';

        return $result;
    }
}

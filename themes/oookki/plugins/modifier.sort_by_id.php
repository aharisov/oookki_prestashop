<?php

function smarty_modifier_sort_by_id($array)
{
    usort($array, function ($a, $b) {
        preg_match('/\d+$/', $a['id'], $aNum);
        preg_match('/\d+$/', $b['id'], $bNum);
        return (int)$aNum[0] <=> (int)$bNum[0];
    });

    return $array;
}
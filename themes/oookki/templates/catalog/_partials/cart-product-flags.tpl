{block name='product_flags'}
  <ul class="badges">
    {* {$product.flags|@print_r} *}
    <li class="badge {$product.flags.type}">{$product.flags.label}</li>
  </ul>
{/block}

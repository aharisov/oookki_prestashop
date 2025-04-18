{block name='product_flags'}
  <ul class="badges">
    {foreach from=$product.flags item=flag}
      <li class="badge {$flag.type}">{$flag.label}</li>
    {/foreach}
  </ul>
{/block}

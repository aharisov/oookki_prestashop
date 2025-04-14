{foreach from=$products item="product" key="position"}
  {include file="catalog/_partials/miniatures/product.tpl" product=$product position=$position}
{/foreach}

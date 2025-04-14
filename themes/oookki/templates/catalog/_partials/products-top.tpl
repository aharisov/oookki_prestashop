<div id="js-product-list-top" class="filter-top">
  <div class="cont flex">
    <div class="left flex total-products">
      <h4 class="js-open-filter">Filtres</h4>
      <div class="result total-products">
        {if $listing.pagination.total_items > 1}
          <p>{l s='<span>%product_count%</span> produits' d='Shop.Theme.Catalog' sprintf=['%product_count%' => $listing.pagination.total_items]}</p>
        {elseif $listing.pagination.total_items > 0}
          <p>{l s='<span>1</span> produit' d='Shop.Theme.Catalog'}</p>
        {/if}
      </div>
    </div>
    <div class="right flex">
      {block name='sort_by'}
        {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
      {/block}
    </div>
  </div>
</div>

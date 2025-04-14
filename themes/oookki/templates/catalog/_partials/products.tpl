<div id="js-product-list">
  <div class="section-products__inner">
    {include file="catalog/_partials/productlist.tpl" products=$listing.products}
  </div>
  {block name='pagination'}
    {include file='_partials/pagination.tpl' pagination=$listing.pagination}
  {/block}
</div>

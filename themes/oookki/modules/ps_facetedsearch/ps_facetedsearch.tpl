{if isset($listing.rendered_facets)}
  <div class="filter-close js-close-filter">
    <i class="fa-solid fa-xmark"></i>
  </div>
  <div class="filter-head flex">
    <span class="filter-head__title">Filtres</span>
    <span class="filter-head__result">
      {if $listing.pagination.total_items > 1}
        <p>{l s='<span>%product_count%</span> produits' d='Shop.Theme.Catalog' sprintf=['%product_count%' => $listing.pagination.total_items]}</p>
      {elseif $listing.pagination.total_items > 0}
        <p>{l s='<span>1</span> produit' d='Shop.Theme.Catalog'}</p>
      {/if}
    </span>
  </div>
  <div id="search_filters_wrapper" class="filter-form">
    {* <div id="search_filter_controls" class="hidden-md-up">
        <span id="_mobile_search_filters_clear_all"></span>
        <button class="btn btn-secondary ok">
          <i class="material-icons rtl-no-flip">&#xE876;</i>
          {l s='OK' d='Shop.Theme.Actions'}
        </button>
    </div> *}
    <div class="filter-inner">
      {$listing.rendered_facets nofilter}
    </div>
</div>
{/if}

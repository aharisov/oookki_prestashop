<section id="js-active-search-filters" class="{if $activeFilters|count}active_filters{else}hide{/if}">
  {block name='active_filters_title'}
    <h4 class="h6 {if $activeFilters|count}active-filter-title{else}hidden{/if}">{l s='Active filters' d='Shop.Theme.Global'}</h4>
  {/block}

  {if $activeFilters|count}
    <ul>
      {foreach from=$activeFilters item="filter"}
        {block name='active_filters_item'}
          <li class="filter-block">
            {l s='%1$s:' d='Shop.Theme.Catalog' sprintf=[$filter.facetLabel]}
            {$filter.label}
            <a class="js-search-link" href="{$filter.nextEncodedFacetsURL}"><i class="fa-solid fa-square-xmark"></i></a>
          </li>
        {/block}
      {/foreach}
    </ul>
  {/if}
</section>

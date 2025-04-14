{if $facets|count}
  <div id="search_filters" class="js-search-filters">
    {block name='facets_clearall_button'}
      {if $activeFilters|count}
        <div id="_desktop_search_filters_clear_all" class="clear-all-wrapper">
          <button data-search-url="{$clear_all_link}" class="btn btn-red__empty js-search-filters-clear-all">
            <i class="fa-solid fa-xmark"></i>
            {l s='Clear all' d='Shop.Theme.Actions'}
          </button>
        </div>
      {/if}
    {/block}

    {foreach from=$facets item="facet"}
      {if !$facet.displayed}
        {continue}
      {/if}

      <section class="facet clearfix filter-block">
        {assign var=_expand_id value=10|mt_rand:100000}
        {assign var=_collapse value=false}
        {foreach from=$facet.filters item="filter"}
          {* {if $filter.active}{assign var=_collapse value=false}{/if}  *}
        {/foreach}

        <h4 role="btn" class="facet-title" aria-active="{if !$_collapse}true{else}false{/if}"><span>{$facet.label}</span></h4>

        {if in_array($facet.widgetType, ['radio', 'checkbox'])}
          {block name='facet_item_other'}
            <div id="facet_{$_expand_id}" class="filter-block__inner" aria-active="{if !$_collapse}true{else}false{/if}">
              {foreach from=$facet.filters key=filter_key item="filter"}
                {if !$filter.displayed}
                  {continue}
                {/if}

                <div class="item">
                  <label class="facet-label{if $filter.active} active {/if}" for="facet_input_{$_expand_id}_{$filter_key}">
                    {if $facet.multipleSelectionAllowed}
                      <input
                          id="facet_input_{$_expand_id}_{$filter_key}"
                          data-search-url="{$filter.nextEncodedFacetsURL}"
                          type="checkbox"
                          {if $filter.active }checked{/if}
                        >
                      {if isset($filter.properties.texture)}
                        <span><i class="color texture" style="background-image:url({$filter.properties.texture})"></i></span>
                      {elseif isset($filter.properties.color)}
                        <span><i class="color" style="background-color:{$filter.properties.color}"></i></span>
                      {else}
                        <span {if !$js_enabled} class="ps-shown-by-js" {/if}></span>
                      {/if}
                    {else}
                      <input
                        id="facet_input_{$_expand_id}_{$filter_key}"
                        data-search-url="{$filter.nextEncodedFacetsURL}"
                        type="radio"
                        name="filter {$facet.label}"
                        {if $filter.active }checked{/if}
                      >
                      <span {if !$js_enabled} class="ps-shown-by-js" {/if}></span>
                    {/if}

                    <a
                      href="{$filter.nextEncodedFacetsURL}"
                      class="_gray-darker search-link js-search-link"
                      rel="nofollow"
                    >
                      {$filter.label}
                      {if $filter.magnitude}
                        <i>({$filter.magnitude})</i>
                      {/if}
                    </a>
                  </label>
                </div>
              {/foreach}
            </div>
          {/block}

        {elseif $facet.widgetType == 'slider'}
          {block name='facet_item_slider'}
            {foreach from=$facet.filters item="filter"}
              <div id="facet_{$_expand_id}"
                class="faceted-slider filter-block__inner"
                data-slider-min="{$facet.properties.min}"
                data-slider-max="{$facet.properties.max}"
                data-slider-id="{$_expand_id}"
                data-slider-values="{$filter.value|@json_encode}"
                data-slider-unit="{$facet.properties.unit}"
                data-slider-label="{$facet.label}"
                data-slider-specifications="{$facet.properties.specifications|@json_encode}"
                data-slider-encoded-url="{$filter.nextEncodedFacetsURL}"
              >
                <div class="item">
                  <p id="facet_label_{$_expand_id}">
                    {$filter.label}
                  </p>

                  <div id="slider-range_{$_expand_id}"></div>
                </div>
              </div>
            {/foreach}
          {/block}

        {else}

          {block name='facet_item_dropdown'}
            <ul id="facet_{$_expand_id}" class="collapse{if !$_collapse} in{/if}">
              <li>
                <div class="col-sm-12 col-xs-12 col-md-12 facet-dropdown dropdown">
                  <a class="select-title" rel="nofollow" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    {$active_found = false}
                    <span>
                      {foreach from=$facet.filters item="filter"}
                        {if $filter.active}
                          {$filter.label}
                          {if $filter.magnitude}
                            ({$filter.magnitude})
                          {/if}
                          {$active_found = true}
                        {/if}
                      {/foreach}
                      {if !$active_found}
                        {l s='(no filter)' d='Shop.Theme.Global'}
                      {/if}
                    </span>
                    <i class="material-icons float-xs-right">&#xE5C5;</i>
                  </a>
                  <div class="dropdown-menu">
                    {foreach from=$facet.filters item="filter"}
                      {if !$filter.active}
                        <a
                          rel="nofollow"
                          href="{$filter.nextEncodedFacetsURL}"
                          class="select-list"
                        >
                          {$filter.label}
                          {if $filter.magnitude}
                            ({$filter.magnitude})
                          {/if}
                        </a>
                      {/if}
                    {/foreach}
                  </div>
                </div>
              </li>
            </ul>
          {/block}
        {/if}
      </section>
    {/foreach}
  </div>
{/if}

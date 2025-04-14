<span class="sort-title sort-by">{l s='Sort by:' d='Shop.Theme.Global'}</span>
<span 
  class="sort-active"
  rel="nofollow"
  data-toggle="dropdown"
  aria-label="{l s='Sort by selection' d='Shop.Theme.Global'}"
  aria-haspopup="true"
  aria-expanded="false">
  {if $listing.sort_selected}{$listing.sort_selected}{else}{l s='Choose' d='Shop.Theme.Actions'}{/if}
</span>
<div class="sort-list products-sort-order dropdown">
  <div class="sort-head flex">
    <span class="sort-head__title">{l s='Sort by:' d='Shop.Theme.Global'}</span>
    <span class="sort-head__active">{if $listing.sort_selected}{$listing.sort_selected}{else}{l s='Choose' d='Shop.Theme.Actions'}{/if}</span>
  </div>
  <div class="sort-close js-sort-close"><i class="fa-solid fa-xmark"></i></div>
  <ul class="sort-list-inner dropdown-menu">
    {foreach from=$listing.sort_orders item=sort_order}
      <li>
        <a
          rel="nofollow"
          href="{$sort_order.url}"
          class="select-list {['current' => $sort_order.current, 'js-search-link' => true]|classnames}"
        >
          {$sort_order.label}
        </a>
      </li>
    {/foreach}
  </ul>
</div>

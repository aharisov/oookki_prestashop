<nav class="pagination page-nav">
  <div class="left-nav">
    {block name='pagination_summary'}
      {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=['%from%' => $pagination.items_shown_from ,'%to%' => $pagination.items_shown_to, '%total%' => $pagination.total_items]}
    {/block}
  </div>

  <div class="right-nav">
    {block name='pagination_page_list'}
     {if $pagination.should_be_displayed}
        <ul class="page-list clearfix text-sm-center">
          {foreach from=$pagination.pages item="page"}


            <li class="{if $page.current}current {/if} {if $page.type === 'previous'}prev {elseif $page.type === 'next'}next {/if}">
              {if $page.type === 'spacer'}
                <span class="spacer">&hellip;</span>
              {else}
                <a
                  rel="{if $page.type === 'previous'}prev{elseif $page.type === 'next'}next{else}nofollow{/if}"
                  href="{$page.url}"
                  class="{['disabled' => !$page.clickable, 'js-search-link' => true]|classnames}"
                  title="{if $page.type === 'previous'}{l s='Previous' d='Shop.Theme.Actions'}{/if}
                    {if $page.type === 'next'}{l s='Next' d='Shop.Theme.Actions'}{/if}"
                >
                  {if $page.type === 'previous'}
                    <i class="fa-solid fa-arrow-left"></i>
                  {elseif $page.type === 'next'}
                    <i class="fa-solid fa-arrow-right"></i>
                  {else}
                    {$page.page}
                  {/if}
                </a>
              {/if}
            </li>
          {/foreach}
        </ul>
      {/if}
    {/block}
  </div>

</nav>

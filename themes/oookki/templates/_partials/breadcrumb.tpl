<nav data-depth="{$breadcrumb.count}" class="breadcrumbs">
  <ul class="flex">
    {block name='breadcrumb'}
      {foreach from=$breadcrumb.links item=path name=breadcrumb}
        {block name='breadcrumb_item'}
          {if not $smarty.foreach.breadcrumb.last}
            <li><a href="{$path.url}">{$path.title}</a></li>
          {else}
            <li><span>{$path.title}</span></li>
          {/if}
        {/block}
      {/foreach}
    {/block}
  </ul>
</nav>

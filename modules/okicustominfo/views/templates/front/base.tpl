{if $items}
  <div class="custom-infoblock">
    {foreach from=$items item=item}
      {$item|@print_r}
      <div class="custom-item">
      </div>
    {/foreach}
  </div>
{/if}
  
<div class="variant-links colors flex">
  {foreach from=$variants item=variant}
    {* {$variant|@print_r} *}
    <span
       class="{$variant.type} {if $comboData.attributes_extra[$activeStorage][$variant.name]['qty'] == 0}not-in-stock{/if}"
       data-tooltip="{$variant.name}"
       aria-label="{$variant.name}"
      {if $variant.texture} style="background-image: url({$variant.texture})" 
      {elseif $variant.html_color_code} style="background-color: {$variant.html_color_code}" {/if}
    ></span>
  {/foreach}
</div>

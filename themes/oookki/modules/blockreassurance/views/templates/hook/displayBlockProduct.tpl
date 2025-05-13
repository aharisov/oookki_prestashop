{if $blocks}
  {* {$blocks|@print_r} *}
  <section class="summary-block why-we">
    <h3 class="title">Pourquoi choisir OOOKKI ?</h3>
    <div class="why-list">
      {foreach from=$blocks item=$block}
        <div class="why-item">
          <span class="icon"><img src="{$block.icon}" alt="{$block.title}" loading="lazy"></span>
          <p>{$block.title}</p>
        </div>
      {/foreach}
    </div>
  </section>
{/if}
{if $elements}
  <section class="summary-block why-we">
    <h3 class="title">Pourquoi choisir OOOKKI ?</h3>
    <div class="why-list">
      {foreach from=$elements item=element}
        <div class="why-item">
          <span class="icon"><img src="{$element.image}" alt="{$element.text}" loading="lazy"></span>
          <p>{$element.text}</p>
        </div>
      {/foreach}
    </div>
  </section>
{/if}

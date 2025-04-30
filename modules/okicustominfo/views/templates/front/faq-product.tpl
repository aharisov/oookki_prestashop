{if count($items) > 0}
  <section class="home-section faq">
    <div class="cont">
      <div class="section-head flex">
        <h2>Besoin d'aide ?</h2>
      </div>
      <div class="faq-list">
        {if $items}
          {foreach from=$items item=item}
            <div class="faq-item accordion-item">
              <div class="faq-item__title accordion-head" role="button" tabindex="0">{$item.question}</div>
              <div class="faq-item__text accordion-content">{$item.answer}</div>
            </div>
          {/foreach}
        {/if}
      </div>
    </div>
  </section>
{/if}
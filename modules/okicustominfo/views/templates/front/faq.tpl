{assign var="show_block" value=false}
{assign var="categories" value=","|explode:$infoblock.categories}

{foreach from=$categories item=cat}
  {if $cat == $category}
      {assign var="show_block" value=true}
  {/if}
{/foreach}

{if $show_block}
  <section class="home-section faq">
    <div class="cont">
      <div class="section-head flex">
          {if $infoblock}
            <h2>{$infoblock.title}</h2>
          {/if}
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
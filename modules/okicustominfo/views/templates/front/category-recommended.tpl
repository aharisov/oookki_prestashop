{assign var="show_block" value=false}

{foreach from=$items item=item}
  {if $category == $item.category_id}
    {assign var="show_block" value=true}
    {assign var="categories" value=","|explode:$item.categories}
  {/if}
{/foreach}

{if $show_block}
  <section class="section-products products-slider recommend-list mb-common">
    <div class="">
      <div class="section-head flex">
        <h2>Accessoires recommandés</h2>
      </div>

      {get_category_products categories=$categories limit=10 assign=products}
      <div class="recommend-slider swiper">
        <div class="swiper-wrapper">
          {foreach from=$products item="product" key="position"}
            {* {$product|@print_r} *}
            {include file="catalog/_partials/miniatures/product-slider-card.tpl" product=$product position=$position}
          {/foreach}
        </div>
        
        <div class="swiper-pagination circle"></div>
        
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
      </div>
    </div>
  </section>
{/if}
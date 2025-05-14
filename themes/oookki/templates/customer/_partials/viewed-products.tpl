<section class="section-products products-slider recommend-list mb-common">
  <div class="">
    <div class="section-head flex">
      <h3>Inspiré de votre historique de navigation</h3>
    </div>

    <div class="recommend-slider swiper">
      <div class="swiper-wrapper">
        {foreach from=$viewed_products item="item" key="position"}
          {block name='product_miniature'}
            {include file='catalog/_partials/miniatures/cart-product-recommend.tpl' product=$item position=$position productClasses=""}
          {/block}
        {/foreach}
      </div>
      
      <div class="swiper-pagination circle"></div>
            
      <div class="swiper-button-prev"></div>
      <div class="swiper-button-next"></div>
    </div>
  </div>
</section>
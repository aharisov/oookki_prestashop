<section class="home-products home-section section-products products-slider mb-common">
  <div class="cont">
    <div class="section-head flex">
      <div class="subtitle">Notre sélection</div>
      <h2>Smartphone <span class="text-red">+ forfait 5G</span></h2>
      <a href="{$allProductsLink}" class="section-link__top link">{l s='Voir tous les téléphones' d='Shop.Theme.Catalog'}</a>
    </div>
    <div class="products-slider swiper">
      <div class="swiper-wrapper">
        {include file="catalog/_partials/products-list-home.tpl" products=$products cssClass="row"}
      </div>

      <div class="swiper-pagination circle"></div>
            
      <div class="swiper-button-prev"></div>
      <div class="swiper-button-next"></div>
    </div>

    <div class="section-link__bottom flex">
      <a href="{$allProductsLink}" class="link">{l s='Voir tous les téléphones' d='Shop.Theme.Catalog'}</a>
    </div>
  </div>
</section>
<section class="home-packs home-section mb-common">
  <div class="cont">
    <div class="section-head flex">
      <h2>Offres forfaits <span class="text-red">sans engagements</span></h2>
      <a href="{$allProductsLink}" class="section-link__top link">{l s='Voir tous les forfaits' d='Shop.Theme.Catalog'}</a>
    </div>
    <div class="packs-list flex">
      <div class="swiper">
        <div class="swiper-wrapper">
          {include file="catalog/_partials/forfait-list-home.tpl" products=$products cssClass="row"}
        </div>
      </div>
    </div>
  </div>
</section>

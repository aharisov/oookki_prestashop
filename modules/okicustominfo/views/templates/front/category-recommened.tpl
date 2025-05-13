<section class="section-products products-slider recommend-list mb-common">
  <div class="">
    <div class="section-head flex">
      <h2>Accessoires recommandés</h2>
    </div>

    <div class="recommend-slider swiper">
      <div class="swiper-wrapper">
        <?php for($i = 1; $i <= 7; $i++):?>
          <div class="swiper-slide">
              <?php include("recommend-item.php")?>
          </div>
        <?php endfor;?>
      </div>
      
      <div class="swiper-pagination circle"></div>
      
      <div class="swiper-button-prev"></div>
      <div class="swiper-button-next"></div>
    </div>
  </div>
</section>
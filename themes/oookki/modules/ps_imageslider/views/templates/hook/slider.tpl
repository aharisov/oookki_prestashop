{if $homeslider.slides}
  <div class="top-slider swiper mb-common">
    <div class="swiper-wrapper">

      {foreach from=$homeslider.slides item=slide name='homeslider'}
        <div class="swiper-slide">
          <div class="slide-inner bg-dark">
            <div class="slide-text">
              <h3 class="title">Avec <img src="images/logo-red5.png" alt=""></h3>
              <div class="anonce effect-glow">{$slide.title}</div>
            </div>
            <div class="slide-photos">
              <figure class="with-caption">
                {if !empty($slide.legend)}
                  <figcaption>{$slide.legend|escape}</figcaption>
                {/if}
                <picture class="slide-product">
                  <img src="{$slide.image_url}" alt="{$slide.legend|escape}" loading="lazy">
                </picture>
              </figure>
              {* {if !empty($slide.url)}<a href="{$slide.url}">{/if} *}
                {$slide.description nofilter}
              {* {if !empty($slide.url)}</a>{/if} *}
            </div>
          </div>
        </div>
      {/foreach}
    
      <div class="swiper-pagination"></div>
      
      <div class="swiper-button-prev"></div>
      <div class="swiper-button-next"></div>
    </div>
  </div>
{/if}

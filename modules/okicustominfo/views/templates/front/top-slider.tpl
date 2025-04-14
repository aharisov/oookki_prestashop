{if $items}
  {* {$page|@print_r} *}
  {if $page.page_name == "index"}
    {assign var="counter" value=1}
  {else}
    {assign var="counter" value=0}
    {foreach from=$items item=slide}
      {* we get selected category ids *}
      {assign var="cat_ids" value=","|explode:$slide.categories}
      {if $category|in_array:$cat_ids}
        {* we watch if current category is in this array *}
        {assign var="counter" value=$counter+1}
      {/if}
    {/foreach}
  {/if}

  {* show slider if min 1 slide found *}
  {if $counter > 0}
  <div class="top-slider swiper mb-common">
    <div class="swiper-wrapper">
      {foreach from=$items item=slide}
        {if $page.page_name == "index"}
          {assign var="show_slide" value=true}
        {else}
          {* we search for the slides in current category *}
          {assign var="show_slide" value=false}
          {assign var="categories" value=","|explode:$slide.categories}
          {if $category|in_array:$categories}
            {assign var="show_slide" value=true}
          {/if}
        {/if}

        {* if slide found, show it *}
        {if $show_slide}
        <div class="swiper-slide">
          <div class="slide-inner bg-dark">
            <div class="slide-text">
              <h3 class="title">{$slide.line1_title} {if $slide.show_logo}<img src="../img/logo-red2.png" alt="">{/if}</h3>
              <div class="anonce effect-glow">{$slide.line2_title}</div>
            </div>
            <div class="slide-photos">
              <figure class="with-caption">
                {if $slide.image_title}
                  <figcaption>{$slide.image_title}</figcaption>
                {/if}
                <picture class="slide-product">
                  <img src="{$slide.image}" alt="" loading="lazy">
                </picture>
              </figure>

              <div class="slide-promo {if $slide.promo_phone_offer}promo-phone{else}promo-other{/if}">
                <div class="title">{$slide.promo_title nofilter}</div>
                <div class="offer flex">
                  {if $slide.promo_phone_offer}
                    <div class="left red-full">{$slide.promo_phone_offer}</div>
                  {/if}
                  <div class="right">
                    {if $slide.promo_offer_text1}
                      <p>{$slide.promo_offer_text1 nofilter}</p>
                    {/if}
                    {if $slide.promo_offer_text2}
                      <p>{$slide.promo_offer_text2 nofilter}</p>
                    {/if}
                  </div>
                </div>

                {if $slide.promo_price_full}
                  <div class="price-wrap flex">
                    <div class="price flex">
                      <div class="num red-full">{$slide.promo_price_full|regex_replace:"/,.*$/":""}</div>
                      <div class="more">
                        <span class="red-full">€ {$slide.promo_price_full|regex_replace:"/^\d+\,(\d+).*/":"$1"}</span>
                      </div>
                    </div>
                    <span>ou</span>
                    <div class="price flex">
                      <div class="num red-full">{$slide.promo_price_monthly|regex_replace:"/,.*$/":""}</div>
                      <div class="more">
                        <span class="red-full">€ {$slide.promo_price_monthly|regex_replace:"/^\d+\,(\d+).*/":"$1"}</span>
                        <i>/ mois TTC</i>
                      </div>
                    </div>
                  </div>
                {else}
                  <div class="price flex">
                    <div class="num red-full">{$slide.promo_price_monthly|regex_replace:"/,.*$/":""}</div>
                    <div class="more">
                      <span class="red-full">€ {$slide.promo_price_monthly|regex_replace:"/^\d+\,(\d+).*/":"$1"}</span>
                      <i>/ mois TTC</i>
                    </div>
                  </div>
                {/if}

                {if $slide.promo_note}
                  <div class="note">{$slide.promo_note nofilter}</div>
                {/if}
              </div>
            </div>
            <div class="swiper-lazy-preloader"></div>
          </div>
        </div>
        {/if}
      {/foreach}
    </div>

    <div class="swiper-pagination"></div>
      
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
  </div>
  {/if}
{/if}
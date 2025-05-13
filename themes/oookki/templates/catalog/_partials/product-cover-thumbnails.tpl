<div class="images-container js-images-container">
  <div class="swiper">
    {* {$product.images|@print_r} *}
    <div class="swiper-wrapper">
      {block name='product_cover'}
        {if !$product.default_image}
          <div class="swiper-slide">
            <picture>
              {if !empty($urls.no_picture_image.bySize.large_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.large_default.sources.avif}" type="image/avif">{/if}
              {if !empty($urls.no_picture_image.bySize.large_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.large_default.sources.webp}" type="image/webp">{/if}
              <img
                src="{$urls.no_picture_image.bySize.large_default.url}"
                loading="lazy"
                width="{$urls.no_picture_image.bySize.large_default.width}"
                height="{$urls.no_picture_image.bySize.large_default.height}"
              >
            </picture>
          </div>
        {/if}
        {foreach from=$product.images item=image}      
          <div class="swiper-slide">
            <picture>
              {if !empty($image.bySize.small_default.sources.avif)}<source srcset="{$image.bySize.small_default.sources.avif}" type="image/avif">{/if}
              {if !empty($image.bySize.small_default.sources.webp)}<source srcset="{$image.bySize.small_default.sources.webp}" type="image/webp">{/if}
              <a href="{$image.bySize.large_default.url}" data-lightbox="gallery">
                <img
                  src="{$image.bySize.medium_default.url}"
                  {if !empty($image.legend)}
                    alt="{$image.legend}"
                    title="{$image.legend}"
                  {else}
                    alt="{$product.name}"
                  {/if}
                  loading="lazy"
                >
              </a>
            </picture>
          </div>
        {/foreach}
      {/block}
    </div>
    <div class="swiper-pagination circle"></div>
    
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
  </div>

  <script>
    if (window.oookkiTheme) {
      window.oookkiTheme.productImagesSlider();
    }
  </script>
</div>
{* {hook h='displayAfterProductThumbs' product=$product} *}
{block name='product_miniature_item'}
  <div class="swiper-slide">
    <div class="product-card">
      {* {$product|@print_r} *}
      {block name='product_thumbnail'}
        <div class="pic">
          {if $product.cover}
            <a href="{$product.url}">
              <picture>
                {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
                {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
                <img
                  src="{$product.cover.bySize.home_default.url}"
                  alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name}{/if}"
                  loading="lazy"
                  data-full-size-image-url="{$product.cover.large.url}"
                />
              </picture>
            </a>
          {else}
            <a href="{$product.url}">
              <picture>
                {if !empty($urls.no_picture_image.bySize.home_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.avif}" type="image/avif">{/if}
                {if !empty($urls.no_picture_image.bySize.home_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.webp}" type="image/webp">{/if}
                <img
                  src="{$urls.no_picture_image.bySize.home_default.url}"
                  loading="lazy"
                />
              </picture>
            </a>
          {/if}
          {include file='catalog/_partials/product-flags.tpl'}

          {foreach from=$product.features item="feature" key="position"}
            {if 6 == $feature["id_feature"]}
              <div class="icon icon{$feature.value}"></div>
            {/if}
          {/foreach}
        </div>
      {/block}

      {block name='product_name'}
        <div class="name-wrap">
          <div class="brand"><a href="">{$product.manufacturer_name}</a></div>
          <div class="name"><a href="{$product.url}">{$product.name}</a></div>
        </div>
      {/block}

      {block name='product_price_and_shipping'}
        <div class="inner js-product-actions">
          {if $product.show_price}
            <div class="price">
              <div class="price-inner">
                <span aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
                  {capture name='custom_price'}{hook h='displayProductPriceBlock' product=$product type='custom_price' hook_origin='products_list'}{/capture}
                  {if '' !== $smarty.capture.custom_price}
                    {$smarty.capture.custom_price nofilter}
                  {else}
                    {$product.price}
                  {/if}
                </span>
                {if $product.has_discount}
                  {hook h='displayProductPriceBlock' product=$product type="old_price"}

                  <span class="price-old" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
                {/if}
              </div>
            </div>
          {/if}
          <button 
            class="btn to-cart btn-red" 
            title="{l s='Add to cart' d='Shop.Theme.Actions'}"
            data-id-product="{$product.id}"
            data-qty="1"
          >
            {if isset($product.cart_quantity) && $product.cart_quantity > 0}
              <i class="fa-solid fa-cart-plus"></i>
            {else}
              <i class="fa-solid fa-basket-shopping"></i>
            {/if}
          </button>
        </div>
      {/block}
    </div>
  </div>
{/block}

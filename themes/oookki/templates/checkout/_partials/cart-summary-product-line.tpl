{block name='cart_summary_product_line'}
  <div class="product-pic">
    <a href="{$product.url}" title="{$product.name}" target="_blank">
      {if $product.default_image}
        <picture>
          {if !empty($product.default_image.small.sources.avif)}<source srcset="{$product.default_image.small.sources.avif}" type="image/avif">{/if}
          {if !empty($product.default_image.small.sources.webp)}<source srcset="{$product.default_image.small.sources.webp}" type="image/webp">{/if}
          <img class="media-object" src="{$product.default_image.small.url}" alt="{$product.name}" loading="lazy">
        </picture>
      {else}
        <picture>
          {if !empty($urls.no_picture_image.bySize.small_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.small_default.sources.avif}" type="image/avif">{/if}
          {if !empty($urls.no_picture_image.bySize.small_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.small_default.sources.webp}" type="image/webp">{/if}
          <img src="{$urls.no_picture_image.bySize.small_default.url}" loading="lazy" />
        </picture>
      {/if}
    </a>
  </div>
  <div class="product-content">
    <div class="product-title">
        <a href="{$product.url}" target="_blank" rel="noopener noreferrer nofollow">{$product.name}</a>
    </div>

    <div class="product-props">
      {if count($product.attributes) > 0}
        {foreach from=$product.attributes key="attribute" item="value"}
          <div class="product-line-info product-line-info-secondary text-muted">
            <span class="label">{$attribute}:</span>
            <span class="value">{$value}</span>
          </div>
        {/foreach}
      {/if}
    </div>

    <div class="product-note">
      <span class="product-quantity">{$product.quantity} x</span>
      <span>{$product.price}</span>
      {hook h='displayProductPriceBlock' product=$product type="unit_price"}
    </div>
  </div>
{/block}

{block name='product_miniature_item'}
  <div class="swiper-slide">
    <div class="product-card">
      {* {$product|@print_r} *}
      {block name='product_thumbnail'}
        <div class="pic">
          {if $product.cover}
            <a href="{$product.url}">
              <picture>
                <img
                  src="http://{$product.cover}"
                  alt="{$product.name}"
                  loading="lazy"
                />
              </picture>
            </a>
          {else}
            <a href="{$product.url}">
              <picture>
                <img
                  src="/img/p/fr-default-home_default.jpg"
                  loading="lazy"
                />
              </picture>
            </a>
          {/if}

          {if $product.flags}
            {include file='catalog/_partials/cart-product-flags.tpl'}
          {/if}
        </div>
      {/block}

      {block name='product_name'}
        <div class="name-wrap">
          {if $product.brand_name}
            <div class="brand"><a href="{$product.brand_url}">{$product.brand_name}</a></div>
          {/if}
          <div class="name"><a href="{$product.url}">{$product.name}</a></div>
        </div>
      {/block}

      {block name='product_price_and_shipping'}
        <div class="inner js-product-actions">
          <div class="price">
            <div class="price-inner">
              <span aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
                {$product.final_price}
              </span>
              {if $product.has_discount}
                {hook h='displayProductPriceBlock' product=$product type="old_price"}

                <span class="price-old" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.original_price}</span>
              {/if}
            </div>
          </div>
          <button 
            class="btn to-cart btn-red in-cart-recommend" 
            title="{l s='Add to cart' d='Shop.Theme.Actions'}"
            data-id-product="{$product.id}"
            data-qty="1"
          >
            {if isset($product->cart_quantity) && $product->cart_quantity > 0}
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

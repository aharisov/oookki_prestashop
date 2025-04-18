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
                  src="{$product.cover}"
                  alt="{$product.name}"
                  loading="lazy"
                />
              </picture>
            </a>
          {/if}
          {include file='catalog/_partials/product-slider-flags.tpl'}
        </div>
      {/block}

      {block name='product_name'}
        <div class="name-wrap">
          {if isset($product.brand)}
            <div class="brand"><a href="">{$product.brand}</a></div>
          {/if}
          <div class="name"><a href="{$product.url}">{$product.name}</a></div>
        </div>
      {/block}

      {block name='product_price_and_shipping'}
        <div class="inner js-product-actions">
          <div class="price">
            <div class="price-inner">
              <span aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
               {$product.price}
              </span>
              {if $product.has_discount}
                {hook h='displayProductPriceBlock' product=$product type="old_price"}

                <span class="price-old" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.old_price}</span>
              {/if}
            </div>
          </div>

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

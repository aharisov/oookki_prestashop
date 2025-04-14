{block name='product_miniature_item'}
  <article class="product-card product-miniature js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">
    {* {$product|@print_r} *}
    <div class="pic">
      {block name='product_thumbnail'}
        {block name='product_variants'}
          {if $product.main_variants}
            {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
          {/if}
        {/block}

        {if $product.cover}
          <a href="{$product.url}" class="thumbnail product-thumbnail">
            <picture>
              {if !empty($product.cover.bySize.home_default.sources.avif)}<source srcset="{$product.cover.bySize.home_default.sources.avif}" type="image/avif">{/if}
              {if !empty($product.cover.bySize.home_default.sources.webp)}<source srcset="{$product.cover.bySize.home_default.sources.webp}" type="image/webp">{/if}
              <img
                src="{$product.cover.bySize.home_default.url}"
                alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}"
                loading="lazy"
                data-full-size-image-url="{$product.cover.large.url}"
              />
            </picture>
            {include file='catalog/_partials/product-flags.tpl'}
            <div class="thumbnail-container" style="display: none;"></div>
          </a>
        {else}
          <a href="{$product.url}" class="thumbnail product-thumbnail">
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

        {foreach from=$product.features item="feature" key="position"}
          {if 6 == $feature["id_feature"]}
            <div class="icon icon{$feature.value}"></div>
          {/if}
        {/foreach}
      {/block}
      {* {block name='quick_view'}
        <a class="quick-view js-quick-view" href="#" data-link-action="quickview">
          <i class="material-icons search">&#xE8B6;</i> {l s='Quick view' d='Shop.Theme.Actions'}
        </a>
      {/block} *}
    </div>

    {block name='product_name'}
      <div class="name-wrap">
        <div class="brand">{$product.manufacturer_name}</div>
        <div class="name"><a href="{$product.url}" content="{$product.url}">{$product.name}</a></div>
      </div>
    {/block}

    <div class="inner">
      {block name='product_price_and_shipping'}
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

            {hook h='displayProductPriceBlock' product=$product type="before_price"}

            {hook h='displayProductPriceBlock' product=$product type='unit_price'}

            {hook h='displayProductPriceBlock' product=$product type='weight'}
          </div>
        {/if}
      {/block}

      <div class="compare">
        <label>
          <input type="checkbox" data-id="{$product.id_product}">
          <span>Comparer</span>
        </label>
      </div>
    </div>

    {assign var="has_feature" value=false}

    {foreach from=$product.features item=feature}
      {if 14 == $feature.id_feature || 15 == $feature.id_feature}
        {assign var="has_feature" value=true}
        {break}
      {/if}
    {/foreach}
    <div class="promo {if !$has_feature}empty{/if}">
      {foreach from=$product.features item=feature}
        {if 14 == $feature.id_feature}
          <p><span class="bold">{$feature.value}€</span> de remise immédiate</p>
        {elseif 15 == $feature.id_feature}
          <p><span class="bold">{$feature.value}€</span> remboursés après achat</p>
        {/if}
      {/foreach}
    </div>
  </article>
{/block}

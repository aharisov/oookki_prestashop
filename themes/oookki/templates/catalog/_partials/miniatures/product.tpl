{block name='product_miniature_item'}
  <article class="product-card {if 5 == $product.id_category_default}mobile{/if} product-miniature js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">
    {* {$product|@print_r} *}

    {* get active product by storage *}
    {if 5 == $product.id_category_default}
      {get_product_combinations id_product=$product.id_product assign=comboData}
      {* {$comboData['attributes_extra']|@print_r} *}
      
      {assign var="foundChecked" value=false}
      {assign var="storageCounter" value=0}
      {foreach from=$comboData.attributes_storage key=storage item=item}
        {if !$foundChecked && $item.qty > 0}
          {assign var="activeStorage" value=$storage}
          {assign var='foundChecked' value=true}
          {assign var="activeStorageIndex" value=$storageCounter}

          {foreach from=$comboData['attributes_extra'][$storage] item=el}
            {if $el.qty > 0}
              {assign var="activeStorageUrl" value=$el.url}
              {break}
            {/if}
          {/foreach}
        {/if}
        {assign var="storageCounter" value=$storageCounter+1}
      {/foreach}
    {/if}

    <div class="pic">
      {block name='product_thumbnail'}
        {block name='product_variants'}
          {if $product.main_variants}
            {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants activeStorage=$activeStorage}
          {/if}
        {/block}

        {if $product.cover}
        <a href="{if $activeStorageUrl}{$activeStorageUrl}{else}{$product.url}{/if}" class="thumbnail product-thumbnail">
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
          </a>
        {else}
          <a href="{if $activeStorageUrl}{$activeStorageUrl}{else}{$product.url}{/if}" class="thumbnail product-thumbnail">
            <picture>
              {if !empty($urls.no_picture_image.bySize.home_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.avif}" type="image/avif">{/if}
              {if !empty($urls.no_picture_image.bySize.home_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.home_default.sources.webp}" type="image/webp">{/if}
              <img
                src="{$urls.no_picture_image.bySize.home_default.url}"
                loading="lazy"
              />
            </picture>
            {include file='catalog/_partials/product-flags.tpl'}
          </a>
        {/if}
        <div class="thumbnail-container" style="display: none;"></div>

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
        <div class="brand"><a href="{$link->getCategoryLink($product.id_category_default)}?q=Marque-{$product.manufacturer_name}">{$product.manufacturer_name}</a></div>
        <div class="name"><a href="{if $activeStorageUrl}{$activeStorageUrl}{else}{$product.url}{/if}" content="{if $activeStorageUrl}{$activeStorageUrl}{else}{$product.url}{/if}">{$product.name}</a></div>
      </div>
    {/block}

    <div class="inner">
      {block name='product_price_and_shipping'}
        {* show storage values for smartphones *}
        {if 5 == $product.id_category_default && $comboData.attributes_storage}
          <ul class="props">
            {assign var=counter value=0}
            {assign var="foundChecked" value=false}
            {foreach from=$comboData.attributes_storage key=storage item=item}
              {* {$item|@print_r} *}
              <li>
                <button 
                  class="product-option {if $item.qty == 0}not-in-stock{/if} {if !$foundChecked && $item.qty > 0}checked {assign var='foundChecked' value=true}{/if}" 
                  data-storage="{$storage}" 
                  data-product="{$product.id_product}"
                  {if $item.qty == 0}disabled{/if}
                >
                  {$storage}
                </button>
              </li>
              {assign var=counter value=$counter+1}
            {/foreach}
          </ul>
        {/if}

        <div class="price-wrap w-margin">
          {if $product.show_price}
            <div class="price">
              {* only for smartphones *}
              {if 5 == $product.id_category_default}
                <div class="price-suptitle">À partir de</div>
              {/if}
              <div class="price-inner">
                <span aria-label="{l s='Price' d='Shop.Theme.Catalog'}">
                  {capture name='custom_price'}{hook h='displayProductPriceBlock' product=$product type='custom_price' hook_origin='products_list'}{/capture}
                  {if '' !== $smarty.capture.custom_price}
                    {$smarty.capture.custom_price nofilter}
                  {else}
                    {* get price based on active storage (for smartphones) *}
                    {if 5 == $product.id_category_default && $activeStorageIndex > 0}
                      {$comboData.attributes_storage[$activeStorage]['price']}
                    {else}
                      {$product.price}
                    {/if}
                  {/if}
                </span>
                {if $product.has_discount}
                  {hook h='displayProductPriceBlock' product=$product type="old_price"}
                  {* get price based on active storage (for smartphones) *}
                  {if 5 == $product.id_category_default && $activeStorageIndex > 0}
                    <span class="price-old" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$comboData.attributes_storage[$activeStorage]['price_original']}</span>
                  {else}
                    <span class="price-old" aria-label="{l s='Regular price' d='Shop.Theme.Catalog'}">{$product.regular_price}</span>
                  {/if}
                {/if}
              </div>

              {* show monthly price (for smartphones) *}
              {if 5 == $product.id_category_default}
                {if $activeStorageIndex > 0}
                  {assign var="result" value=$comboData.attributes_storage[$activeStorage]['price_raw']/3}
                {else}
                  {assign var="result" value=$product.price_amount/3}
                {/if}
                <div class="price-credit">
                  <span>ou <i>{$result|string_format:"%.2f"}</i>€</span>
                  <span>/ mois x 3 mois</span>
                </div>
              {/if}
            </div>

            {hook h='displayProductPriceBlock' product=$product type="before_price"}

            {hook h='displayProductPriceBlock' product=$product type='unit_price'}

            {hook h='displayProductPriceBlock' product=$product type='weight'}
          
          {/if}

          {if 5 != $product.id_category_default}
            <button 
              class="btn to-cart btn-red" 
              type="submit"
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
          {/if}
        </div>
      {/block}

      <div class="compare">
        <label>
          <input type="checkbox" data-id="{$product.id_product}">
          <span>Comparer</span>
        </label>
      </div>
    </div>

    {* show promo info *}
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

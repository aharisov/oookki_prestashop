{extends file=$layout}

{block name='head' append}
  <meta property="og:type" content="product">
  {if $product.cover}
    <meta property="og:image" content="{$product.cover.large.url}">
  {/if}

  {if $product.show_price}
    <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
    <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
    <meta property="product:price:amount" content="{$product.price_amount}">
    <meta property="product:price:currency" content="{$currency.iso_code}">
  {/if}
  {if isset($product.weight) && ($product.weight != 0)}
  <meta property="product:weight:value" content="{$product.weight}">
  <meta property="product:weight:units" content="{$product.weight_unit}">
  {/if}
{/block}

{block name='head_microdata_special'}
  {include file='_partials/microdata/product-jsonld.tpl'}
{/block}

{block name='content'}
  <div class="cont product-container js-product-container">
    <meta content="{$product.url}">

    {include file='catalog/_partials/product-top.tpl'}

    <article id="product-info" class="product-info tab-panel flex" aria-hidden="false">
      {block name='page_content_container'}
        <div id="product-photo-slider" class="product-page__slider">
          <div class="inner">
            {include file='catalog/_partials/product-flags.tpl'}

            {block name='product_cover_thumbnails'}
              {include file='catalog/_partials/product-cover-thumbnails.tpl'}
            {/block}

            {foreach from=$product.features item="feature" key="position"}
              {if 6 == $feature["id_feature"]}
                <div class="icon icon{$feature.value|lower}"></div>
              {/if}
            {/foreach}
          </div>
        </div>
      
        <div class="product-info__inner">
          {block name='page_header_container'}
            {* {$product|@print_r} *}
            {* {hook h='displayProductActions' product=$product} *}
            {block name='page_header'}
              <div class="product-title">
                {if !empty($product.id_manufacturer)}
                  <div class="brand">
                    <a href="{$link->getManufacturerLink($product.id_manufacturer)}">
                      {$product.manufacturer_name}
                    </a>
                  </div>
                {/if}
                <h1>{block name='page_title'}{$product.name}{/block}</h1>

                {if count($groups) > 0}  
                <div class="model">
                  {foreach from=$groups key=id_attribute_group item=group}
                    {foreach from=$group.attributes key=id_attribute item=group_attribute}
                      {if $group_attribute.selected}
                        {$group_attribute.name}
                        {if $group.name == 'Stockage'} - {/if}
                      {/if}
                    {/foreach}
                  {/foreach}
                </div>
                {/if}
              </div>

              {if !empty($product.description_short)}
                <div class="product-info__short">{$product.description_short nofilter}</div>
              {/if}
            {/block}
          {/block}

          {hook h='displayCartExtraProductActions' product=$product}
          {* TODO reprise de l'ancienne appareil *}
          {* <div class="return-calculate">
            <button class="flex">
              <div class="icon">€</div>
              <p>Estimez votre ancien mobile et profitez d’une remise de 100€ supplémentaire</p>
            </button>
          </div> *}

          {assign var="promoCount" value=0}
          {foreach from=$product.features item="feature"}
            {if 14 == $feature.id_feature || 15 == $feature.id_feature}
              {assign var="promoCount" value=$promoCount+1}
            {/if}
          {/foreach}

          {if $promoCount > 0}
            {include file='catalog/_partials/product-promos.tpl'}
          {/if}

          <div class="product-information product-configurator">
            {* {if $product.is_customizable && count($product.customizations.fields)}
              {block name='product_customization'}
                {include file="catalog/_partials/product-customization.tpl" customizations=$product.customizations}
              {/block}
            {/if} *}
            
            <div class="js-product-actions">
              {block name='product_buy'}
                <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                  <input type="hidden" name="token" value="{$static_token}">
                  <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                  <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id" class="js-product-customization-id">

                  {block name='product_variants'}
                    {include file='catalog/_partials/product-variants.tpl'}
                  {/block}

                  {block name='product_pack'}
                    {if $packItems}
                      <section class="product-pack">
                        <p class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</p>
                        {foreach from=$packItems item="product_pack"}
                          {block name='product_miniature'}
                            {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack showPackProductsPrice=$product.show_price}
                          {/block}
                        {/foreach}
                      </section>
                    {/if}
                  {/block}

                  <div class="product-summary ">
                    {block name='product_prices'}
                      {include file='catalog/_partials/product-prices.tpl'}
                    {/block}

                    {block name='product_discounts'}
                      {include file='catalog/_partials/product-discounts.tpl'}
                    {/block}

                    {block name='product_add_to_cart'}
                      {include file='catalog/_partials/product-add-to-cart.tpl'}
                    {/block}

                    {block name='product_additional_info'}
                      {include file='catalog/_partials/product-additional-info.tpl'}
                    {/block}

                    {* Input to refresh product HTML removed, block kept for compatibility with themes *}
                    {block name='product_refresh'}{/block}
                  </div>
                </form>
              {/block}

            </div>

            {block name='hook_display_reassurance'}
              {hook h='displayReassurance'}
            {/block}
          
          </div>
        </div>
      {/block}

      {block name='product_footer'}
        {* {hook h='displayFooterProduct' product=$product category=$category} *}
      {/block}
    </article>

    <article id="product-features" class="product-features tab-panel" aria-hidden="true"></article>
    <article id="product-description" class="product-description tab-panel" aria-hidden="true"></article>

    {block name='product_accessories'}
      {if $accessories}
        <section class="product-accessories clearfix">
          <p class="h5 text-uppercase">{l s='You might also like' d='Shop.Theme.Catalog'}</p>
          <div class="products row">
            {foreach from=$accessories item="product_accessory" key="position"}
              {block name='product_miniature'}
                {include file='catalog/_partials/miniatures/product.tpl' product=$product_accessory position=$position productClasses="col-xs-12 col-sm-6 col-lg-4 col-xl-3"}
              {/block}
            {/foreach}
          </div>
        </section>
      {/if}
    {/block}

    {block name='product_images_modal'}
      {* {include file='catalog/_partials/product-images-modal.tpl'} *}
    {/block}

  </div>

{/block}

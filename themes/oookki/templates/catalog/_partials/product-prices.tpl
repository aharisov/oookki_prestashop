{if $product.show_price}
  <div class="product-prices js-product-prices" content="{$product.rounded_display_price}">
    <h3>Détail du prix</h3>
    
    <div class="current-price" style="display: none;">
      <span class='current-price-value'>{$product.price}</span>
    </div>
    {if 3 == $product.id_category_default || 11 == $product.id_category_default}
      <div class="product-price">
        {block name='product_price'}
          <div class="current-price">
            <span class='current-price-value' content="{$product.rounded_display_price}">
              {capture name='custom_price'}{hook h='displayProductPriceBlock' product=$product type='custom_price' hook_origin='product_sheet'}{/capture}
              {if '' !== $smarty.capture.custom_price}
                {$smarty.capture.custom_price nofilter}
              {else}
                {$product.price}
              {/if}
            </span>
          </div>
        {/block}

        {block name='product_discount'}
          {if $product.has_discount}
            <div class="product-discount">
              {hook h='displayProductPriceBlock' product=$product type="old_price"}
              <span class="regular-price">{$product.regular_price}</span>
            </div>
          {/if}
        {/block}
      </div>
    {else}
      <div class="summary-inner pay-cash" aria-hidden="false">
        <div class="summary-block">
          <ul>
            <li>
                <span class="left"><strong>{$product.name}</strong></span>
                <span class="right"><strong>{$product.price}</strong></span>
            </li>
            {foreach from=$product.features item="feature"}
              {if 14 == $feature.id_feature || 15 == $feature.id_feature}
                <li>
                    <span class="left">{$feature.name} €</span>
                    <span class="right">{$feature.value} €</span>
                </li>
              {/if}
            {/foreach}
          </ul>
        </div>
      </div>
    {/if}
    
    {block name='product_without_taxes'}
      {if $priceDisplay == 2}
        <p class="product-without-taxes">{l s='%price% tax excl.' d='Shop.Theme.Catalog' sprintf=['%price%' => $product.price_tax_exc]}</p>
      {/if}
    {/block}

    {block name='product_pack_price'}
      {if $displayPackPrice}
        <p class="product-pack-price"><span>{l s='Instead of %price%' d='Shop.Theme.Catalog' sprintf=['%price%' => $noPackPrice]}</span></p>
      {/if}
    {/block}

    {block name='product_ecotax'}
        {if !$product.is_virtual && $product.ecotax.amount > 0}
        <p class="price-ecotax">{l s='Including %amount% for ecotax' d='Shop.Theme.Catalog' sprintf=['%amount%' => $product.ecotax.value]}
          {if $product.has_discount}
            {l s='(not impacted by the discount)' d='Shop.Theme.Catalog'}
          {/if}
        </p>
      {/if}
    {/block}

    {hook h='displayProductPriceBlock' product=$product type="weight" hook_origin='product_sheet'}
  </div>
{/if}

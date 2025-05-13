<div id="order-items" class="summary-block order-summary-block">
  <h3 class="title">Détails de la commande</h3>
  
  <div class="summary-products">
    {block name='order_confirmation_table'}
      {foreach from=$products item=product}
        <div class="summary-product">
          <div class="product-pic">
            {if $add_product_link}<a href="{$product.url}" target="_blank">{/if}
              {if !empty($product.default_image)}
                <picture>
                  {if !empty($product.default_image.medium.sources.avif)}<source srcset="{$product.default_image.medium.sources.avif}" type="image/avif">{/if}
                  {if !empty($product.default_image.medium.sources.webp)}<source srcset="{$product.default_image.medium.sources.webp}" type="image/webp">{/if}
                  <img src="{$product.default_image.medium.url}" loading="lazy" />
                </picture>
              {else}
                <picture>
                  {if !empty($urls.no_picture_image.bySize.medium_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.medium_default.sources.avif}" type="image/avif">{/if}
                  {if !empty($urls.no_picture_image.bySize.medium_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.medium_default.sources.webp}" type="image/webp">{/if}
                  <img src="{$urls.no_picture_image.bySize.medium_default.url}" loading="lazy" />
                </picture>
              {/if}
            {if $add_product_link}</a>{/if}
          </div>
          <div class="product-content">
            <div class="product-title">
              {if $add_product_link}<a href="{$product.url}" target="_blank">{/if}
                <span>{$product.name}</span>
              {if $add_product_link}</a>{/if}
            </div>
            <div class="product-props">{$product.quantity} x {$product.price}</div>
            {if count($product.attributes) > 0}
              <div class="product-props">{$product.attributes|@print_r}</div>
            {/if}
          </div>
          <div class="product-price">{$product.total}</div>
          {* {hook h='displayProductPriceBlock' product=$product type="unit_price"} *}
        </div>
        {* {$product|@print_r} *}
      {/foreach}

      <div class="summary-block pay-summary order-summary-block">
        <div class="pay-block all-info">
          <ul>
            {foreach $subtotals as $subtotal}
              {if $subtotal !== null && $subtotal.type !== 'tax' && $subtotal.label !== null}
                <li>
                  <span>{$subtotal.label}</span>
                  <span>{if 'discount' == $subtotal.type}-&nbsp;{/if}{$subtotal.value}</span>
                </li>
              {/if}
            {/foreach}
          </ul>
          
          {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
            <div class="sum flex">
              <div class="left">{$totals.total.label}&nbsp;{$labels.tax_short}</div>
              <div class="right">{$totals.total.value}</div>
            </div>
            <div class="sum flex">
              <div class="left">{$totals.total_including_tax.label}</div>
              <div class="right">{$totals.total_including_tax.value}</div>
            </div>
          {else}
            <div class="sum flex">
              <div class="left">{$totals.total.label}&nbsp;{if $configuration.taxes_enabled && $configuration.display_taxes_label}{$labels.tax_short}{/if}</div>
              <div class="right">{$totals.total.value}</div>
            </div>
          {/if}
          {if $subtotals.tax !== null && $subtotals.tax.label !== null}
            <div class="sum flex">
              <div class="left">{l s='%label%:' sprintf=['%label%' => $subtotals.tax.label] d='Shop.Theme.Global'}</div>
              <div class="right">{$subtotals.tax.value}</div>
            </div>
          {/if}
        </div>

        {block name='order_details'}
          <div class="pay-block all-info">
            <ul>
              <li>
                <span>{l s='Payment method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => '']}</span>
                <span>{$order.details.payment}</span>
              </li>
              {if !$order.details.is_virtual}
                <li>
                  <span>{l s='Shipping method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => '']}</span>
                  <span>{$order.carrier.name} ({$order.carrier.delay})</span>
                </li>
              {/if}
              {if $order.details.recyclable}
                <li>  
                  <span>{l s='You have given permission to receive your order in recycled packaging.' d="Shop.Theme.Customeraccount"}</span>
                </li>
              {/if}
            </ul>
            <div id="order-reference-value" class="sum flex">
              <div class="left">{l s='Order reference: %reference%' d='Shop.Theme.Checkout' sprintf=['%reference%' => '']}</div>
              <div class="right">{$order.details.reference}</div>
            </div>
          </div>
        {/block}
      </div>
    {/block}
  </div>
</div>

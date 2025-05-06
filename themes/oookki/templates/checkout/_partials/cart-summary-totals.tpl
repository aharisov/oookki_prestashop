<div class="card-block cart-summary-totals js-cart-summary-totals">

  {block name='cart_summary_total'}
    {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
      <div class="cart-summary-line sum flex">
        <span class="label left">{$cart.totals.total.label}&nbsp;{$cart.labels.tax_short}</span>
        <span class="value right">{$cart.totals.total.value}</span>
      </div>
      <div class="cart-summary-line cart-total sum flex">
        <span class="label left">{$cart.totals.total_including_tax.label}</span>
        <span class="value right">{$cart.totals.total_including_tax.value}</span>
      </div>
    {else}
      <div class="cart-summary-line cart-total sum flex">
        <span class="label left">{$cart.totals.total.label}&nbsp;{if $configuration.display_taxes_label && $configuration.taxes_enabled}{$cart.labels.tax_short}{/if}</span>
        <span class="value right">{$cart.totals.total.value}</span>
      </div>
    {/if}
  {/block}

  {block name='cart_summary_tax'}
    {if $cart.subtotals.tax}
      <div class="cart-summary-line sum flex">
        <span class="label sub left">{l s='%label%:' sprintf=['%label%' => $cart.subtotals.tax.label] d='Shop.Theme.Global'}</span>
        <span class="value sub right">{$cart.subtotals.tax.value}</span>
      </div>
    {/if}
  {/block}

</div>

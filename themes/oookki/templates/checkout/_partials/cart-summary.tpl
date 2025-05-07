<section id="js-checkout-summary" class="card js-cart" data-refresh-url="{$urls.pages.cart}?ajax=1&action=refresh">
  <div class="card-block">
    {* {block name='hook_checkout_summary_top'}
      {include file='checkout/_partials/cart-summary-top.tpl' cart=$cart}
    {/block} *}

    {block name='cart_summary_products'}
      {include file='checkout/_partials/cart-summary-products.tpl' cart=$cart}
    {/block}
  </div>

  <div class="summary-block pay-summary">
    <h3 class="title">Votre paiement</h3>

    <div class="pay-block all-info">
      {block name='cart_summary_subtotals'}
        {include file='checkout/_partials/cart-summary-subtotals.tpl' cart=$cart}
      {/block}

      {block name='cart_summary_totals'}
        {include file='checkout/_partials/cart-summary-totals.tpl' cart=$cart}
      {/block}
  
      {block name='cart_summary_voucher'}
        {include file='checkout/_partials/cart-voucher.tpl'}
      {/block}
    </div>
  </div>
</section>

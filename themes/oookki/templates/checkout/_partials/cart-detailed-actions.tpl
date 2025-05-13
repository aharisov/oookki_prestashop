{block name='cart_detailed_actions'}
  <div class="checkout cart-detailed-actions js-cart-detailed-actions buttons-wrap">
    {if $cart.minimalPurchaseRequired}
      <div class="alert alert-warning" role="alert">
        {$cart.minimalPurchaseRequired}
      </div>
      <button type="button" class="btn btn-black icon-left disabled" disabled>
        <i class="fa-solid fa-cart-shopping"></i>
        <span>{l s='Proceed to checkout' d='Shop.Theme.Actions'}</span>
      </button>
    {elseif empty($cart.products) }
      <button type="button" class="btn btn-black icon-left disabled" disabled>
        <i class="fa-solid fa-cart-shopping"></i>
        <span>{l s='Proceed to checkout' d='Shop.Theme.Actions'}</span>
      </button>
    {else}
      <a href="{$urls.pages.order}" class="btn btn-black icon-left">
        <i class="fa-solid fa-cart-shopping"></i>
        <span>{l s='Proceed to checkout' d='Shop.Theme.Actions'}</span>
      </a>
      {hook h='displayExpressCheckout'}
    {/if}
  </div>
{/block}

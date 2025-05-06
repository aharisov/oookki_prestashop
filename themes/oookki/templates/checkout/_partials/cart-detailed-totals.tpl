{block name='cart_detailed_totals'}
<div class="cart-detailed-totals js-cart-detailed-totals">

  <div class="card-block cart-detailed-subtotals js-cart-detailed-subtotals summary-block pay-summary">
    <h3 class="title">Votre commande</h3>
    <div class="pay-block all-info">
      <ul>
        {foreach from=$cart.subtotals item="subtotal"}
          {if $subtotal && $subtotal.value|count_characters > 0 && $subtotal.type !== 'tax'}
            <li class="cart-summary-line" id="cart-subtotal-{$subtotal.type}">
              <span class="label{if 'products' === $subtotal.type} js-subtotal{/if}">
                {if 'products' == $subtotal.type}
                  {$cart.summary_string}
                {else}
                  {$subtotal.label}
                {/if}
              </span>
              <span class="value">
                {if 'discount' == $subtotal.type}-&nbsp;{/if}{$subtotal.value}

                {if $subtotal.type === 'shipping'}
                  <small class="value">{hook h='displayCheckoutSubtotalDetails' subtotal=$subtotal}</small>
                {/if}
              </span>
            </li>
          {/if}
        {/foreach}
      </ul>
      
      {block name='cart_summary_totals'}
        {include file='checkout/_partials/cart-summary-totals.tpl' cart=$cart}
      {/block}
      {block name='cart_voucher'}
        {include file='checkout/_partials/cart-voucher.tpl'}
      {/block}
    </div>
  </div>
</div>
{/block}

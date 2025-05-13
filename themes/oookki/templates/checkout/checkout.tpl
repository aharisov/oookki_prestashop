{extends file=$layout}

{block name='content'}
  <section id="content">
    <div class="order-wrap flex">
      <div class="order-content">
        {block name='checkout_process'}
          {render file='checkout/checkout-process.tpl' ui=$checkout_process}
        {/block}
      </div>
      <div class="cart-summary">
        {block name='cart_summary'}
          {include file='checkout/_partials/cart-summary.tpl' cart=$cart}
        {/block}
        {hook h='displayReassurance'}
      </div>
    </div>
  </section>
{/block}

{* {block name='footer'}
  {include file='checkout/_partials/footer.tpl'}
{/block} *}

{extends file=$layout}

{block name='content'}

  <section id="main" class="order-wrap flex">
    <div class="cont">
    <!-- Left Block -->
    <div class="order-content">
      {include file='checkout/_partials/cart-detailed.tpl' cart=$cart}
      {block name='continue_shopping'}
        <a class="label" href="{$urls.pages.index}">
          <i class="fa-solid fa-chevron-left"></i>{l s='Continue shopping' d='Shop.Theme.Actions'}
        </a>
      {/block}
    </div>
    <!-- Right Block -->
    <aside class="cart-summary">
      {block name='cart_overview'}
        <section class="summary-block card cart-container">
          <h3 class="title">Votre panier</h3>          
          
        </section>
      {/block}

      {block name='cart_summary'}
        

          
            {block name='hook_shopping_cart'}
              {hook h='displayShoppingCart'}
            {/block}
          
          
          {block name='cart_totals'}
            {include file='checkout/_partials/cart-detailed-totals.tpl' cart=$cart}
          {/block}

          {block name='cart_actions'}
            {include file='checkout/_partials/cart-detailed-actions.tpl' cart=$cart}
          {/block}

        
      {/block}

      {block name='hook_reassurance'}
        {hook h='displayReassurance'}
      {/block}
    </aside>
    
    {hook h='displayCrossSellingShoppingCart'}
    </div>
  </section>
{/block}

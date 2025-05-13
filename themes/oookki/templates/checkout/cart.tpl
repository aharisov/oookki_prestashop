{extends file=$layout}

{block name='content'}

  <section id="main">
    <div class="cont">
      <div class="order-wrap flex">
        <!-- Left Block: cart product informations & shipping -->
        <div class="order-content">

          <!-- cart products detailed -->
          {* {$cart|@print_r} *}
          <div class="card cart-container mb-common">
            <h1 class="h1">{l s='Shopping Cart' d='Shop.Theme.Checkout'}</h1>
            {block name='cart_overview'}
              {include file='checkout/_partials/cart-detailed.tpl' cart=$cart}
            {/block}

            {block name='notifications'}
              {include file='_partials/notifications.tpl'}
            {/block}
          </div>

          {block name='continue_shopping'}
            <div class="order-buttons">
              <a class="link order-reset label" href="{$urls.pages.index}">
                <i class="fa-solid fa-chevron-left"></i>
                <span>{l s='Continue shopping' d='Shop.Theme.Actions'}</span>
              </a>

              {block name='cart_actions'}
                {include file='checkout/_partials/cart-detailed-actions.tpl' cart=$cart}
              {/block}
            </div>
          {/block}

          <!-- shipping informations -->
          {block name='hook_shopping_cart_footer'}
            {hook h='displayShoppingCartFooter'}
          {/block}
        </div>

        <!-- Right Block: cart subtotal & cart total -->
        <div class="cart-summary">
          {block name='cart_summary'}
            {* {block name='hook_shopping_cart'}
              {hook h='displayShoppingCart'}
            {/block} *}

            {block name='cart_totals'}
              {include file='checkout/_partials/cart-detailed-totals.tpl' cart=$cart}
            {/block}
          {/block}

          {block name='hook_reassurance'}
            {hook h='displayReassurance'}
          {/block}
        </div>
      </div>
    </div>
    
    {* {hook h='displayCrossSellingShoppingCart'} *}

    {if $recommended}
      <section class="section-products products-slider recommend-list mb-common">
        <div>
          <div class="section-head flex">
            <h2>{l s='You might also like' d='Shop.Theme.Catalog'}</h2>
          </div>
          <div class="recommend-slider swiper">
            <div class="swiper-wrapper">
              {foreach from=$recommended item="item" key="position"}
                {block name='product_miniature'}
                  {include file='catalog/_partials/miniatures/cart-product-recommend.tpl' product=$item position=$position productClasses=""}
                {/block}
              {/foreach}
              <div class="swiper-pagination circle"></div>
          
              <div class="swiper-button-prev"></div>
              <div class="swiper-button-next"></div>
          </div>
        </div>
      </section>
    {/if}
    
  </section>
{/block}

<div class="header-btn btn-cart {if $cart.products_count > 0}active{else}inactive{/if}" data-refresh-url="{$refresh_url}">
  {if $cart.products_count > 0}
    <a rel="nofollow" aria-label="{l s='Shopping cart link containing %nbProducts% product(s)' sprintf=['%nbProducts%' => $cart.products_count] d='Shop.Theme.Checkout'}" href="{$cart_url}">
  {/if}
    <i class="fa-solid fa-cart-shopping"></i>
    <i class="cnt">{$cart.products_count}</i>
    <span class="hidden-sm-down">{l s='Cart' d='Shop.Theme.Checkout'}</span>
  {if $cart.products_count > 0}
    </a>
  {/if}
</div>


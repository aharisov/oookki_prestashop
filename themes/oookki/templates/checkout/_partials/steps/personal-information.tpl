{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  {hook h='displayPersonalInformationTop' customer=$customer}

  {if $customer.is_logged && !$customer.is_guest}
    <div class="basket-block pay-summary">
      <div class="pay-block">
      <p class="identity">
        {* [1][/1] is for a HTML tag. *}
        {l s='Connected as [1]%firstname% %lastname%[/1].'
          d='Shop.Theme.Customeraccount'
          sprintf=[
            '[1]' => "<a href='{$urls.pages.identity}' class='link'>",
            '[/1]' => "</a>",
            '%firstname%' => $customer.firstname,
            '%lastname%' => $customer.lastname
          ]
        }
      </p>
      <p>
        {* [1][/1] is for a HTML tag. *}
        {l
          s='Not you? [1]Log out[/1]'
          d='Shop.Theme.Customeraccount'
          sprintf=[
          '[1]' => "<p><a href='{$urls.actions.logout}' class='btn btn-black__empty'>",
          '[/1]' => "</a></p>"
          ]
        }
      </p>
      </div>
      {if !isset($empty_cart_on_logout) || $empty_cart_on_logout}
        <p class="order-note">{l s='If you sign out now, your cart will be emptied.' d='Shop.Theme.Checkout'}</p>
      {/if}
    </div>

    <div class="order-buttons full">
      <a href="/" class="link order-reset">
          <i class="fa-solid fa-xmark"></i> 
          <span>Abandonner ma commande</span>
      </a>
      <div class="buttons-wrap">
        <form method="GET" action="{$urls.pages.order}">
          <button
            class="continue btn btn-black"
            name="controller"
            type="submit"
            value="order"
          >
            {l s='Continue' d='Shop.Theme.Actions'}
          </button>
        </form>
      </div>
    </div>

  {else}
    {* <p>Connectez-vous pour profiter d'une remise et gagner du temps à la souscription.</p> *}
    
    <ul class="nav order-info-nav flex" role="tablist">
      <li class="nav-item {if !$show_login_form}active{/if}">
        <a
          class="nav-link"
          data-toggle="tab"
          href="#checkout-guest-form"
          role="tab"
          aria-controls="checkout-guest-form"
          {if !$show_login_form} aria-selected="true"{/if}
          >
          {if $guest_allowed}
            {l s='Order as a guest' d='Shop.Theme.Checkout'}
          {else}
            {l s='Create an account' d='Shop.Theme.Customeraccount'}
          {/if}
        </a>
      </li>

      <li class="nav-item {if $show_login_form}active{/if}">
        <a
          class="nav-link"
          data-link-action="show-login-form"
          data-toggle="tab"
          href="#checkout-login-form"
          role="tab"
          aria-controls="checkout-login-form"
          {if $show_login_form} aria-selected="true"{/if}
        >
          {l s='Sign in' d='Shop.Theme.Actions'}
        </a>
      </li>
    </ul>

    <div class="tab-content">
      <div class="tab-pane {if !$show_login_form}active{/if}" id="checkout-guest-form" role="tabpanel" {if $show_login_form}aria-hidden="true"{/if}>
        {render file='checkout/_partials/customer-form.tpl' ui=$register_form guest_allowed=$guest_allowed}
      </div>
      <div class="tab-pane {if $show_login_form}active{/if}" id="checkout-login-form" role="tabpanel" {if !$show_login_form}aria-hidden="true"{/if}>
        {render file='checkout/_partials/login-form.tpl' ui=$login_form}
      </div>
    </div>


  {/if}
{/block}

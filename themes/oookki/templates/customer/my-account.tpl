{extends file='customer/page.tpl'}

{block name='page_title'}
  <h1>{l s='Your account' d='Shop.Theme.Customeraccount'}</h1>
{/block}

{block name='page_content'}
  <div class="profile-links mb-common">
    <div id="identity-link" class="profile-link">
      <a href="{$urls.pages.identity}">
        <span class="icon"><i class="fa-solid fa-circle-user"></i></span>
        <span class="name">
          {l s='Information' d='Shop.Theme.Customeraccount'}
        </span>
      </a>
    </div>

    {if $customer.addresses|count}
      <div id="address-link" class="profile-link">
        <a href="{$urls.pages.addresses}">
          <span class="icon"><i class="fa-solid fa-location-dot"></i></span>
          <span class="name">
            {l s='Addresses' d='Shop.Theme.Customeraccount'}
          </span>
        </a>
      </div>
    {else}
      <div id="address-link" class="profile-link">
        <a href="{$urls.pages.address}">
          <span class="icon"><i class="fa-solid fa-location-dot"></i></span>
          <span class="name">
            {l s='Add first address' d='Shop.Theme.Customeraccount'}
          </span>
        </a>
      </div>
    {/if}

    {if !$configuration.is_catalog}
      <div id="history-link" class="profile-link">
        <a href="{$urls.pages.history}">
          <span class="icon"><i class="fa-solid fa-clock-rotate-left"></i></span>
          <span class="name">
            {l s='Order history and details' d='Shop.Theme.Customeraccount'}
          </span>
        </a>
      </div>
    {/if}

    {* {if !$configuration.is_catalog}
      <div id="order-slips-link" class="profile-link">
        <a href="{$urls.pages.order_slip}">
          <span class="link-item">
            <i class="material-icons">&#xE8B0;</i>
            {l s='Credit slips' d='Shop.Theme.Customeraccount'}
          </span>
        </a>
      </div>
    {/if} *}

    {* {if $configuration.voucher_enabled && !$configuration.is_catalog}
      <div id="discounts-link" class="profile-link">
        <a href="{$urls.pages.discount}">
          <span class="link-item">
            <i class="material-icons">&#xE54E;</i>
            {l s='Vouchers' d='Shop.Theme.Customeraccount'}
          </span>
        </a>
      </div>
    {/if} *}

    {* {if $configuration.return_enabled && !$configuration.is_catalog}
      <div id="returns-link" class="profile-link">
        <a href="{$urls.pages.order_follow}">
          <span class="link-item">
            <i class="material-icons">&#xE860;</i>
            {l s='Merchandise returns' d='Shop.Theme.Customeraccount'}
          </span>
        </a>
      </div>
    {/if} *}

    {* {$viewed_products|@print_r} *}
    {block name='display_customer_account'}
      {hook h='displayCustomerAccount'}
    {/block}
  </div>
  <a href="/?mylogout=" class="btn btn-black icon-left">
    <i class="fa-solid fa-right-from-bracket"></i>
    <span>Déconnexion</span>
  </a>
{/block}


{block name='page_footer'}
  {block name='my_account_links'}
    <div class="text-sm-center">
      <a href="{$urls.actions.logout}" >
        {l s='Sign out' d='Shop.Theme.Actions'}
      </a>
    </div>
  {/block}
{/block}

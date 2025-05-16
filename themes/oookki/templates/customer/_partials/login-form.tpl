{block name='login_form'}

  {block name='login_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}

  <form id="login-form" class="js-login-form {if $page.page_name == 'authentication'} auth-form login-form{/if}" action="{block name='login_form_actionurl'}{$action}{/block}" method="post">
    {if $page.page_name == 'authentication'}
      <div class="form-title">
        <i class="fa-solid fa-user-pen"></i>
        <h1>Connectez-vous à votre compte</h1>
      </div>
    {/if}
    <div class="{if $page.page_name != 'authentication'}personal-block{/if}">
      <div class="{if $page.page_name != 'authentication'}auth-form{/if}">
        {block name='login_form_fields'}
          {foreach from=$formFields item="field"}
            {block name='form_field'}
              {form_field field=$field num=1}
            {/block}
          {/foreach}
        {/block}
        <div class="forgot-password">
          <a href="{$urls.pages.password}" class="link" rel="nofollow">
            {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
          </a>
        </div>
      </div>
    </div>

    {block name='login_form_footer'}
      {if $page.page_name == 'authentication'}
        <div class="form-line button-line">
          <input type="hidden" name="submitLogin" value="1">
          {block name='form_buttons'}
            <button id="submit-login" class="btn btn-black" data-link-action="sign-in" type="submit" class="form-control-submit">
              {l s='Sign in' d='Shop.Theme.Actions'}
            </button>
          {/block}

          <p class="no-account">
            <a href="{$urls.pages.register}" class="link" data-link-action="display-register-form">
              {l s='No account? Create one here' d='Shop.Theme.Customeraccount'}
            </a>
          </p>
        </div>
      {else}
        <div class="order-buttons">
          <a href="/" class="link order-reset">
              <i class="fa-solid fa-xmark"></i> 
              <span>Abandonner ma commande</span>
          </a>
          <div class="buttons-wrap">
            <input type="hidden" name="submitLogin" value="1">
            {block name='form_buttons'}
              <button id="submit-login" class="btn btn-red" data-link-action="sign-in" type="submit" class="form-control-submit">
                {l s='Sign in' d='Shop.Theme.Actions'}
              </button>
            {/block}
          </div>
        </div>
      {/if}
    {/block}

  </form>
{/block}

{block name='login_form'}

  {block name='login_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}

  <form id="login-form" class="js-login-form" action="{block name='login_form_actionurl'}{$action}{/block}" method="post">

    <div class="personal-block">
      <div class="auth-form">
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
    {/block}

  </form>
{/block}

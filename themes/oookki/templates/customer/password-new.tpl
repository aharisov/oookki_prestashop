{extends file='page.tpl'}

{block name='page_title'}
  {l s='Reset your password' d='Shop.Theme.Customeraccount'}
{/block}

{block name='page_content'}
  <div class="cont">
    <form action="{$urls.pages.password}" method="post" class="restore-form auth-form">
    <div class="form-title">
      <i class="fa-solid fa-key"></i>
      <h1>{l s='Reset your password' d='Shop.Theme.Customeraccount'}</h1>
    </div>
    <ul class="ps-alert-error">
      {foreach $errors as $error}
        <li class="alert alert-danger item">
          <svg viewBox="0 0 24 24">
            <path fill="#fff" d="M11,15H13V17H11V15M11,7H13V13H11V7M12,2C6.47,2 2,6.5 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,20A8,8 0 0,1 4,12A8,8 0 0,1 12,4A8,8 0 0,1 20,12A8,8 0 0,1 12,20Z"></path>
          </svg>
          <p>{$error}</p>
        </li>
      {/foreach}
    </ul>
    <section class="form-fields renew-password">

      <div class="email top-note">
        {l
          s='Email address: %email%'
          d='Shop.Theme.Customeraccount'
          sprintf=['%email%' => $customer_email|stripslashes]}
      </div>

        <div class="container-fluid field-password-policy">
          <div class="form-line form-group">
            <label class="form-control-label form-line__title">{l s='New password' d='Shop.Forms.Labels'}</label>
            <div class="js-input-column">
              <input
                class="form-control"
                type="password"
                data-validate="isPasswd"
                name="passwd"
                value=""
                required
                {if isset($configuration.password_policy.minimum_length)}data-minlength="{$configuration.password_policy.minimum_length}"{/if}
                {if isset($configuration.password_policy.maximum_length)}data-maxlength="{$configuration.password_policy.maximum_length}"{/if}
                {if isset($configuration.password_policy.minimum_score)}data-minscore="{$configuration.password_policy.minimum_score}"{/if}
              >
            </div>
          </div>

          <div class="form-line form-group">
            <label class="form-control-label form-line__title">{l s='Confirmation' d='Shop.Forms.Labels'}</label>
            <input class="form-control" type="password" data-validate="isPasswd" name="confirmation" value="" required>
          </div>

          <input type="hidden" name="token" id="token" value="{$customer_token}">
          <input type="hidden" name="id_customer" id="id_customer" value="{$id_customer}">
          <input type="hidden" name="reset_token" id="reset_token" value="{$reset_token}">

          <div class="form-line">
            <button class="btn btn-black" type="submit" name="submit">
              {l s='Change Password' d='Shop.Theme.Actions'}
            </button>
          </div>
        </div>

      </section>
    </form>
  </div>
{/block}

{block name='page_footer'}
  <ul>
    <li><a href="{$urls.pages.authentication}">{l s='Back to Login' d='Shop.Theme.Actions'}</a></li>
  </ul>
{/block}

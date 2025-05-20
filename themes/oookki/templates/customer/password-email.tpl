{extends file='page.tpl'}

<div class="cont">
  {block name='page_content'}

    <form action="{$urls.pages.password}" class="forgotten-password restore-form auth-form" method="post">
      <div class="form-title">
        <i class="fa-solid fa-key"></i>
        <h1>{l s='Forgot your password?' d='Shop.Theme.Customeraccount'}</h1>
      </div>

      <p class="top-note send-renew-password-link">{l s='Please enter the email address you used to register. You will receive a temporary link to reset your password.' d='Shop.Theme.Customeraccount'}</p>

      <ul class="ps-alert-error">
        {foreach $errors as $error}
          <li class="item">
            <i>
              <svg viewBox="0 0 24 24">
                <path fill="#fff" d="M11,15H13V17H11V15M11,7H13V13H11V7M12,2C6.47,2 2,6.5 2,12A10,10 0 0,0 12,22A10,10 0 0,0 22,12A10,10 0 0,0 12,2M12,20A8,8 0 0,1 4,12A8,8 0 0,1 12,4A8,8 0 0,1 20,12A8,8 0 0,1 12,20Z"></path>
              </svg>
            </i>
            <p>{$error}</p>
          </li>
        {/foreach}
      </ul>

      <div class="form-line">
        <label class="form-line__title form-control-label required" data-name="e-mail">{l s='Email address' d='Shop.Forms.Labels'} <span class="red">*</span></label>
        <input type="email" name="email" id="email" value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}" class="form-control" required>
        {* <button id="send-reset-link" class="form-control-submit btn btn-primary hidden-xs-down" name="submit" type="submit">
          {l s='Send reset link' d='Shop.Theme.Actions'}
        </button> *}
        {* <button class="form-control-submit btn btn-primary hidden-sm-up" name="submit" type="submit">
          {l s='Send' d='Shop.Theme.Actions'}
        </button> *}
      </div>

      <div class="form-line">
        <button id="send-reset-link" class="form-control-submit btn btn-black" name="submit" type="submit">
          {l s='Send reset link' d='Shop.Theme.Actions'}
        </button>
      </div>
      
      <div class="form-note"><span class="red">*</span> Champs obligatoires</div>
    </form>
  {/block}

  {block name='page_footer'}
    <a id="back-to-login" href="{$urls.pages.my_account}" class="account-link">
      <i class="material-icons">&#xE5CB;</i>
      <span>{l s='Back to login' d='Shop.Theme.Actions'}</span>
    </a>
  {/block}
</div>
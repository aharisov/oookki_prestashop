<section class="block-newsletter" id="blockEmailSubscription_{$hookName}">
  <div class="cont">
    <h3>{l s='Get our latest news and special sales' d='Shop.Theme.Global'}</h3>
    <form action="{$urls.current_url}#blockEmailSubscription_{$hookName}" method="post">
        <div class="form-line">
          <input
            name="email"
            type="email"
            value="{$value}"
            placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
            aria-labelledby="block-newsletter-label"
            required
          >
          <input
            class="btn btn-black"
            name="submitNewsletter"
            type="submit"
            value="{l s='Subscribe' d='Shop.Theme.Actions'}"
          >
          <input type="hidden" name="blockHookName" value="{$hookName}" />
          <input type="hidden" name="action" value="0">
        </div>
        <div class="notes">
            {if $conditions}
              <p>{$conditions}</p>
            {/if}
            <div class="block_newsletter_alert">
            {if $msg}
              <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
                {$msg}
              </p>
            {/if}
            </div>
            {hook h='displayNewsletterRegistration'}
            {if isset($id_module)}
              {hook h='displayGDPRConsent' id_module=$id_module}
            {/if}
        </div>
    </form>
  </div>
</section>

{block name='account_transformation_form'}
  <h3>{l s='Save time on your next order, sign up now' d='Shop.Theme.Checkout'}</h3>
  <form method="post">
    <div class="form-line">
      <label class="form-line__title required" for="field-email">
        {l s='Set your password:' d='Shop.Forms.Labels'}
      </label>
      <input type="password" class="form-control" data-validate="isPasswd" required name="password" value="">
      <ul class="note" style="flex-direction: column;">
        <li> - {l s='Personalized and secure access' d='Shop.Theme.Customeraccount'}</li>
        <li> - {l s='Fast and easy checkout' d='Shop.Theme.Customeraccount'}</li>
        <li> - {l s='Easier merchandise return' d='Shop.Theme.Customeraccount'}</li>
      </ul>
    </div>
    <div class="form-line">
      <input type="hidden" name="submitTransformGuestToCustomer" value="1">
      <button class="btn btn-black" type="submit">{l s='Create account' d='Shop.Theme.Actions'}</button>
    </div>
  </form>
{/block}

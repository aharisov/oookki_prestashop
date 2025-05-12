{extends file='checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  <div id="hook-display-before-carrier">
    {$hookDisplayBeforeCarrier nofilter}
  </div>

  <div class="delivery-options-list">
    {if $delivery_options|count}
      <form
        class="clearfix"
        id="js-delivery"
        data-url-update="{url entity='order' params=['ajax' => 1, 'action' => 'selectDeliveryOption']}"
        method="post"
      >
        <div class="form-fields basket-block line-config-block">
          {block name='delivery_options'}
            <div class="delivery-options config-options delivery-options accordion-container">
              {foreach from=$delivery_options item=carrier key=carrier_id}
                  <div class="config-option accordion-item delivery-option js-delivery-option">
                    <div class="switch accordion-head">
                      <input type="radio" name="delivery_option[{$id_address}]" id="delivery_option_{$carrier.id}" value="{$carrier_id}"{if $delivery_option == $carrier_id} checked{/if}>
                      <label for="delivery_option_{$carrier.id}" class="label-pic">
                        {if $carrier.logo}
                          <img src="{$carrier.logo}" alt="{$carrier.name}" loading="lazy">
                        {else}
                          <i class="fa-regular fa-image"></i>
                        {/if}
                      </label>
                      <div class="switch-right">
                        <label for="delivery_option_{$carrier.id}">{$carrier.name}</label>
                        <i class="note price">{$carrier.price}</i>
                      </div>
                    </div>

                    <p class="config-text">{$carrier.delay}</p>
                    {if $carrier.extraContent}
                      <div class="accordion-content carrier-extra-content js-carrier-extra-content">
                        {$carrier.extraContent nofilter}
                      </div>
                    {/if}
                  </div>
              {/foreach}
            </div>
          {/block}
          <div class="order-options">
            <div id="delivery" class="form-line full">
              <label for="delivery_message">{l s='If you would like to add a comment about your order, please write it in the field below.' d='Shop.Theme.Checkout'}</label>
              <textarea rows="2" cols="120" id="delivery_message" name="delivery_message">{$delivery_message}</textarea>
            </div>

            {if $recyclablePackAllowed}
              <span class="custom-checkbox">
                <input type="checkbox" id="input_recyclable" name="recyclable" value="1" {if $recyclable} checked {/if}>
                <span><i class="material-icons rtl-no-flip checkbox-checked">&#xE5CA;</i></span>
                <label for="input_recyclable">{l s='I would like to receive my order in recycled packaging.' d='Shop.Theme.Checkout'}</label>
              </span>
            {/if}

            {if $gift.allowed}
              <span class="custom-checkbox">
                <input class="js-gift-checkbox" id="input_gift" name="gift" type="checkbox" value="1" {if $gift.isGift}checked="checked"{/if}>
                <span><i class="material-icons rtl-no-flip checkbox-checked">&#xE5CA;</i></span>
                <label for="input_gift">{$gift.label}</label >
              </span>

              <div id="gift" class="collapse{if $gift.isGift} in{/if}">
                <label for="gift_message">{l s='If you\'d like, you can add a note to the gift:' d='Shop.Theme.Checkout'}</label>
                <textarea rows="2" cols="120" id="gift_message" name="gift_message">{$gift.message}</textarea>
              </div>
            {/if}

          </div>
        </div>

        <div class="order-buttons full">
          <a href="/" class="link order-reset">
              <i class="fa-solid fa-xmark"></i> 
              <span>Abandonner ma commande</span>
          </a>
          <div class="buttons-wrap">
            <button type="button" class="btn btn-black__empty prev-step" data-prev-step="checkout-addresses-step">Précédent</button>
            <button type="submit" class="continue btn btn-red" name="confirmDeliveryOption" value="1">
              {l s='Continue' d='Shop.Theme.Actions'}
            </button>
          </div>
        </div>
      </form>
    {else}
      <p class="alert alert-danger">{l s='Unfortunately, there are no carriers available for your delivery address.' d='Shop.Theme.Checkout'}</p>
    {/if}
  </div>

  <div id="hook-display-after-carrier">
    {$hookDisplayAfterCarrier nofilter}
  </div>

  <div id="extra_carrier"></div>
{/block}

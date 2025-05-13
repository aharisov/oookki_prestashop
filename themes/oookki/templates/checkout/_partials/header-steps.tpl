{* {$steps|@print_r} *}
{if $page.page_name == 'order-confirmation'}
  {assign var="class" value="ready"}
{else}
  {assign var="class" value=""}
{/if}
<div class="order-steps">
  {* <div class="order-step current">
    <i class="fa-solid fa-gear"></i>
  </div> *}
  <div class="order-step current {$class}" data-step-id="checkout-personal-information-step" data-step-name="Mes données" data-step="1" data-icon="fa-regular fa-circle-user">
    {* <span></span> *}
    <i class="fa-regular fa-circle-user"></i>
  </div>
  <div class="order-step {$class}" data-step-id="checkout-addresses-step" data-step-name="Mes adresses" data-step="2" data-icon="fa-solid fa-map-location-dot">
    <span></span>
    <i class="fa-solid fa-map-location-dot"></i>
  </div>
  <div class="order-step {$class}" data-step-id="checkout-delivery-step" data-step-name="Livraison" data-step="3" data-icon="fa-solid fa-truck">
    <span></span>
    <i class="fa-solid fa-truck"></i>
  </div>
  <div class="order-step {$class}" data-step-id="checkout-payment-step" data-step-name="Paiement" data-step="4" data-icon="fa-solid fa-credit-card">
    <span></span>
    <i class="fa-solid fa-credit-card"></i>
  </div>
  <div class="order-step {$class}" data-step-id="" data-step-name="Confirmation" data-step="5" data-icon="fa-solid fa-circle-check">
    <span></span>
    <i class="fa-solid fa-circle-check"></i>
  </div>
</div>
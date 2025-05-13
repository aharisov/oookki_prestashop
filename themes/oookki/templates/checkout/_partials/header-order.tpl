<div class="cont">
  <div class="header__inner flex">
    {renderLogo}
    {* {block name='checkout_process'}
      {render file='checkout/checkout-process-light.tpl' ui=$checkout_process}
    {/block} *}
    {include file='checkout/_partials/header-steps.tpl'}
    {include file='checkout/_partials/header-current-step.tpl'}    
  </div>
</div>
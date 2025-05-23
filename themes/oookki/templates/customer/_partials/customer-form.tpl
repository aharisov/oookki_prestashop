{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}
{block name='customer_form'}
  {block name='customer_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}

<form action="{block name='customer_form_actionurl'}{$action}{/block}" id="customer-form" class="js-customer-form" method="post">
  <div class="personal-block">
    <div class="personal-block__inner">
      {block "form_fields"}
        {foreach from=$formFields item="field"}
          {block "form_field"}
            {form_field field=$field num=''}
          {/block}
        {/foreach}
        {$hook_create_account_form nofilter}
      {/block}
    </div>
  </div>

  {block name='customer_form_footer'}
    <div class="order-buttons full">
      <input type="hidden" name="submitCreate" value="1">
      <a href="/" class="link order-reset">
        <i class="fa-solid fa-xmark"></i>
        <span>Abandonner ma commande</span>
      </a>
      <div class="buttons-wrap" bis_skin_checked="1">
        {block "form_buttons"}
          <button class="btn btn-red form-control-submit" data-link-action="save-customer" type="submit">
            {l s='Save' d='Shop.Theme.Actions'}
          </button>
        {/block}
      </div>
    </div>

    <div class="order-note"><span class="red">*</span> Champs obligatoires</div>
  {/block}

</form>
{/block}

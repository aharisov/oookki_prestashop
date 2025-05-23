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
{block name="address_form"}
  <div class="js-address-form">
    {include file='_partials/form-errors.tpl' errors=$errors['']}

    {block name="address_form_url"}
    <form
      method="POST"
      action="{url entity='address' params=['id_address' => $id_address]}"
      data-id-address="{$id_address}"
      data-refresh-url="{url entity='address' params=['ajax' => 1, 'action' => 'addressForm']}"
    >
    {/block}

      {block name="address_form_fields"}
        <section class="form-fields">
          <div class="personal-block personal-info">
            {block name='form_fields'}
              <div class="personal-block__inner">
                {foreach from=$formFields item="field"}
                  {block name='form_field'}
                    {form_field field=$field num=""}
                  {/block}
                {/foreach}
              </div>
            {/block}
          </div>
        </section>
      {/block}

      {block name="address_form_footer"}
        <div class="order-buttons full">
          <a href="/" class="link order-reset">
              <i class="fa-solid fa-xmark"></i> 
              <span>Abandonner ma commande</span>
          </a>
          <div class="buttons-wrap">
            <input type="hidden" name="submitAddress" value="1">
            {block name='form_buttons'}
              <a href="order-step1.php" class="btn btn-black__empty prev-step">Étape précédente</a>
              <button class="btn btn-red next-step form-control-submit" type="submit">
                {l s='Save' d='Shop.Theme.Actions'}
              </button>
            {/block}
          </div>
        </div>
      {/block}

    </form>
  </div>
{/block}

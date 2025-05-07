{if $field.type == 'hidden'}

  {block name='form_field_item_hidden'}
    <input type="hidden" name="{$field.name}" value="{$field.value|default}">
  {/block}

{else}

  <div class="form-line form-group
    {if $field.name == 'email'} full-line{/if} 
    {if ($field.type === 'radio-buttons')} full-line{/if} 
    {if !empty($field.errors)}has-error{/if}
    {if ($field.type === 'checkbox')} with-checkbox full-line{/if}
  ">
    <label class="form-line__title form-control-label{if $field.required} required{/if}" for="field-{$field.name}"
      data-name="{$field.label}">
      {if $field.type !== 'checkbox'}
        {$field.label}
      {/if}
      {if $field.required && $field.type !== 'checkbox'}<span class="red">*</span>{/if}
      {if (!$field.required && !in_array($field.type, ['radio-buttons', 'checkbox']))}
        {l s='(Optionnel)' d='Shop.Forms.Labels'}
      {/if}
    </label>
    <div class="form-line__content js-input-column{if ($field.type === 'radio-buttons')} radio-group form-control-valign{/if}">

      {if $field.type === 'select'}

        {block name='form_field_item_select'}
          <select id="field-{$field.name}" class="form-control form-control-select" name="{$field.name}" {if $field.required}required{/if}>
            <option value disabled selected>{l s='Please choose' d='Shop.Forms.Labels'}</option>
            {foreach from=$field.availableValues item="label" key="value"}
              <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
            {/foreach}
          </select>
        {/block}

      {elseif $field.type === 'countrySelect'}

        {block name='form_field_item_country'}
          <select
            id="field-{$field.name}"
            class="form-control form-control-select js-country"
            name="{$field.name}"
            {if $field.required}required{/if}
          >
            <option value disabled selected>{l s='Please choose' d='Shop.Forms.Labels'}</option>
            {foreach from=$field.availableValues item="label" key="value"}
              <option value="{$value}" {if $value eq $field.value} selected {/if}>{$label}</option>
            {/foreach}
          </select>
        {/block}

      {elseif $field.type === 'radio-buttons'}

        {block name='form_field_item_radio'}
          {foreach from=$field.availableValues item="label" key="value"}
            <label class="radio-inline" for="field-{$field.name}-{$value}">
              <input
                name="{$field.name}"
                id="field-{$field.name}-{$value}"
                type="radio"
                value="{$value}"
                {if $field.required}required{/if}
                {if $value eq $field.value} checked {/if}
              >
              <span>{$label}</span>
            </label>
          {/foreach}
        {/block}

      {elseif $field.type === 'checkbox'}

        {block name='form_field_item_checkbox'}
            <label>
              <input name="{$field.name}" type="checkbox" value="1" {if $field.value}checked="checked"{/if} {if $field.required}required{/if}>
              <span>{$field.label nofilter} {if $field.required}<i class="red">*</i>{/if}</span>
            </label>
        {/block}

      {elseif $field.type === 'date'}

        {block name='form_field_item_date'}
          <input id="field-{$field.name}" name="{$field.name}" class="form-control" type="date" value="{$field.value|default}"{if isset($field.availableValues.placeholder)} placeholder="{$field.availableValues.placeholder}"{/if}>
          {* {if isset($field.availableValues.comment)}
            <span class="note form-control-comment">
              {$field.availableValues.comment}
            </span>
          {/if} *}
        {/block}

      {elseif $field.type === 'birthday'}

        {block name='form_field_item_birthday'}
          {* <div class="js-parent-focus"> *}
            {html_select_date
            field_order=DMY
            time={$field.value|default}
            field_array={$field.name}
            prefix=false
            reverse_years=true
            field_separator='<br>'
            day_extra='class="form-control form-control-select"'
            month_extra='class="form-control form-control-select"'
            year_extra='class="form-control form-control-select"'
            day_empty={l s='-- day --' d='Shop.Forms.Labels'}
            month_empty={l s='-- month --' d='Shop.Forms.Labels'}
            year_empty={l s='-- year --' d='Shop.Forms.Labels'}
            start_year={'Y'|date}-100 end_year={'Y'|date}
            }
          {* </div> *}
        {/block}

      {elseif $field.type === 'password'}

        {block name='form_field_item_password'}
          {* <div class="input-group js-parent-focus"> *}
            <input
              id="field-{$field.name}{$num}"
              class="form-control js-child-focus js-visible-password"
              name="{$field.name}"
              aria-label="{l s='Password input' d='Shop.Forms.Help'}"
              type="password"
              {if isset($configuration.password_policy.minimum_length)}data-minlength="{$configuration.password_policy.minimum_length}"{/if}
              {if isset($configuration.password_policy.maximum_length)}data-maxlength="{$configuration.password_policy.maximum_length}"{/if}
              {if isset($configuration.password_policy.minimum_score)}data-minscore="{$configuration.password_policy.minimum_score}"{/if}
              {if $field.autocomplete}autocomplete="{$field.autocomplete}"{/if}
              value=""
              pattern=".{literal}{{/literal}5,{literal}}{/literal}"
              {if $field.required}required{/if}
            >
            <button type="button" class="btn btn-black js-toggle-pass">
              <i class="fa-solid fa-eye"></i>
              <i class="fa-solid fa-eye-slash"></i>
            </button>
            {* <span class="input-group-btn">
              <button
                class="btn"
                type="button"
                data-action="show-password"
                data-text-show="{l s='Show' d='Shop.Theme.Actions'}"
                data-text-hide="{l s='Hide' d='Shop.Theme.Actions'}"
              >
                {l s='Show' d='Shop.Theme.Actions'}
              </button>
            </span> *}
          {* </div> *}
        {/block}

      {else}

        {block name='form_field_item_other'}
          <input
            id="field-{$field.name}{$num}"
            class="form-control"
            name="{$field.name}"
            type="{$field.type}"
            value="{$field.value|default}"
            {if $field.autocomplete}autocomplete="{$field.autocomplete}"{/if}
            {if isset($field.availableValues.placeholder)}placeholder="{$field.availableValues.placeholder}"{/if}
            {if $field.maxLength}maxlength="{$field.maxLength}"{/if}
            {if $field.required}required{/if}
          >
          {if isset($field.availableValues.comment)}
            <div class="note form-control-comment">
              <i>i</i>
              <span>{$field.availableValues.comment}</span>
            </div>
          {/if}
        {/block}

      {/if}

      {block name='form_field_errors'}
        {include file='_partials/form-errors.tpl' errors=$field.errors}
      {/block}

    </div>

    {* <div class="note form-control-comment">
      {block name='form_field_comment'}
        {if (!$field.required && !in_array($field.type, ['radio-buttons', 'checkbox']))}
         {l s='Optional' d='Shop.Forms.Labels'}
        {/if}
      {/block}
    </div> *}
  </div>

{/if}

{if count($groups) > 0}
<div class="js-product-variants">
  <h3>Je choisi ma configuration</h3>
  {* {$new_combinations|@print_r} *}
  <div class="product-options">
    {foreach from=$groups key=id_attribute_group item=group}
      {if !empty($group.attributes)}
        {* get active stockage *}
        {if $group.name == "Stockage"}
          {foreach from=$group.attributes key=id_attribute item=group_attribute}
            {if $group_attribute.selected}
              {assign var="activeStorage" value=$group_attribute.name}
            {/if}
          {/foreach}
        {/if}
        <div class="option-block">
          <h5>Choisissez votre {$group.name|lower}</h5>
          {* {$group|@print_r} *}
          {if $group.group_type == 'select'}
            <select
              class="form-control form-control-select"
              id="group_{$id_attribute_group}"
              aria-label="{$group.name}"
              data-product-attribute="{$id_attribute_group}"
              name="group[{$id_attribute_group}]">
              {foreach from=$group.attributes key=id_attribute item=group_attribute}
                <option value="{$id_attribute}" title="{$group_attribute.name}"{if $group_attribute.selected} selected="selected"{/if}>{$group_attribute.name}</option>
              {/foreach}
            </select>
          {elseif $group.group_type == 'color'}
            <ul id="group_{$id_attribute_group}" class="option-props flex color">
              {foreach from=$group.attributes key=id_attribute item=group_attribute}
                <li>
                  <input 
                    id="{$group_attribute.name|lower}{$id_attribute}"
                    class="input-color" 
                    type="radio" 
                    data-product-attribute="{$id_attribute_group}" 
                    name="group[{$id_attribute_group}]" 
                    value="{$id_attribute}" 
                    title="{$group_attribute.name}"
                    {if $new_combinations[$activeStorage]['colors'][$group_attribute.name] == 0} disabled{/if}
                    {if $group_attribute.selected} checked="checked"{/if}
                  >  
                  <label for="{$group_attribute.name|lower}{$id_attribute}" aria-label="{$group_attribute.name}">
                    <span
                      {if $group_attribute.texture}
                        class="color texture" style="background-image: url({$group_attribute.texture})"
                      {elseif $group_attribute.html_color_code}
                        class="color" style="background-color: {$group_attribute.html_color_code}"
                      {/if}
                    ></span>
                    <p class="attribute-name">{$group_attribute.name}</p>
                  </label>
                </li>
              {/foreach}
            </ul>
          {elseif $group.group_type == 'radio'}
            <ul id="group_{$id_attribute_group}" class="option-props flex capacity">
              {foreach from=$group.attributes key=id_attribute item=group_attribute}
                <li class="input-container">
                  <input 
                    id="item_attr_{$id_attribute}"
                    class="input-radio" 
                    type="radio" 
                    data-product-attribute="{$id_attribute_group}" 
                    name="group[{$id_attribute_group}]" 
                    value="{$id_attribute}" 
                    title="{$group_attribute.name}"
                    {if $group.attributes_quantity[$id_attribute] == 0} disabled{/if}
                    {if $group_attribute.selected} checked="checked"{/if}
                  >
                  <label for="item_attr_{$id_attribute}">
                    <span class="radio-label">{$group_attribute.name}</span>
                  </label>
                </li>
              {/foreach}
            </ul>
          {/if}
        </div>
      {/if}
    {/foreach}
  </div>
</div>
{/if}
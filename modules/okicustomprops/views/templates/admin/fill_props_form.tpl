<h2>{$product->name|escape:'html'}</h2>
<div class="col-md-6" style="margin-top: 30px; margin-bottom: 50px;">
  <form method="post" action="{$form_action|escape:'html'}">
    <input type="hidden" name="id_product" value="{$product->id|intval}" />
    {foreach from=$groups item=group}
      <fieldset>
        <legend>{$group.name|escape:'html'}</legend>
        {foreach from=$group.props item=prop}
          <div class="form-group">
            <label for="prop_{$prop.id_property}">{$prop.name|escape:'html'}</label>
            {if $prop.input_type == 'text'}
              <input type="text" name="prop_{$prop.id_property}" value="{$prop.value|escape:'html':'UTF-8'}" class="form-control"/>
            {/if}
            {if $prop.input_type == 'checkbox'}
              <br>
              <input 
                id="prop_{$prop.id_property}" 
                type="checkbox" 
                name="prop_{$prop.id_property}" 
                value="1" 
                {if $prop.value == 1}checked{/if} 
                class="checkbox"
              />
            {/if}
          </div>
        {/foreach}
      </fieldset>
    {/foreach}

    <button type="submit" name="submitProps" class="btn btn-primary">
      {l s='Enregistrer' mod='okicustomprops'}
    </button>
  </form>
</div>
<div class="col-md-12">
  <a href="{$returnUrl}" class="btn btn-default">{$return_button_text}</a>
</div>
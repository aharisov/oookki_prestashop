{block name='content'}
  <div class="panel">
    <h3>{$block_name} - {l s='Add Item' mod='okicustominfo'}</h3>

    <form method="post" action="{$link->getAdminLink('AdminOkiCustomInfoAddItem')}&id_block={$id_block}{if isset($smarty.get.from_items)}&from_items={$smarty.get.from_items}{/if}" enctype="multipart/form-data">
      <div class="mb-2">
        {counter start=0 assign=counter}
        {foreach from=$fields["name"] item=field}
          {* {$field|@print_r} *}
          {if $field != null}
            {if $fields["type"][$counter] == "image"}
              <div class="form-group d-flex">
                <label>{$field}</label>
                <input type="file" name="item[image]" class="form-control" />
                <input type="hidden" name="type[{$field|replace:' ':'_'|lower}]" value="{$fields["type"][$counter]}">
              </div>
            {elseif $fields["type"][$counter] == "BOOLEAN"}
              <div class="form-group d-flex">
                <label>{$field}</label>
                <input type="checkbox" name="item[{$field|replace:' ':'_'|lower}]" value="1" {if $field|replace:' ':'_'|lower}checked{/if} class="form-control" />
                <input type="hidden" name="type[{$field|replace:' ':'_'|lower}]" value="{$fields["type"][$counter]}">
              </div>
            {else}  
              <div class="form-group d-flex">
                {if $field|replace:' ':'_'|lower == 'product_name'}
                  <label>{$field}</label>
                  <select id="product-select" name="item[{$field|replace:' ':'_'|lower}]" class="form-control">
                    <option value="">-- Choisir un produit --</option>
                    {foreach from=$products item=product}
                      <option value="{$product['name']}" data-id={$product['id']}>{$product['name']}</option>
                    {/foreach}
                  </select>
                {elseif $field|replace:' ':'_'|lower == 'product_id'}
                  <input id="product-id" type="hidden" name="item[{$field|replace:' ':'_'|lower}]" class="form-control" />
                {else}
                  <label>{$field}</label>
                  <input type="text" name="item[{$field|replace:' ':'_'|lower}]" class="form-control" />
                {/if}
                <input type="hidden" name="type[{$field|replace:' ':'_'|lower}]" value="{$fields["type"][$counter]}">
              </div>
            {/if}
            {counter}
          {/if}
        {/foreach}
        
        <div class="form-group d-flex flex-column">
          <label for="item_categories">
            Catégories (pour obtenir des données ou pour afficher)
          </label>
          {$categories nofilter}
        </div>
      </div>
      
      <div class="panel-footer">
        <a href="{$link->getAdminLink('AdminOkiCustomInfoItems')|escape:'html':'UTF-8'}&id_block={$id_block}" class="btn btn-secondary">
          <i class="material-icons">arrow_back</i> {l s='Retourner' d='Admin.Actions'}
        </a>
        <button type="submit" name="submit_add_item" class="btn btn-primary pull-right">{l s='Sauvegarder' mod='okicustominfo'}</button>
      </div>
    </form>
  </div>
{/block}

{block name='content'}
  <div class="panel">
    <h3>{$block_name} - {l s='Add Item' mod='okicustominfo'}</h3>

    <form method="post" action="{$link->getAdminLink('AdminOkiCustomInfoAddItem')}&id_block={$id_block}{if isset($smarty.get.from_items)}&from_items={$smarty.get.from_items}{/if}" enctype="multipart/form-data">
      <div class="mb-2">
        {counter start=0 assign=counter}
        {foreach from=$fields["name"] item=field}
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
              <label>{$field}</label>
              <input type="text" name="item[{$field|replace:' ':'_'|lower}]" class="form-control" />
              <input type="hidden" name="type[{$field|replace:' ':'_'|lower}]" value="{$fields["type"][$counter]}">
            </div>
          {/if}
          {counter}
        {/foreach}
        <div class="form-group d-flex flex-column">
          <label for="item_categories">Catégories</label>
          <select name="item[categories][]" multiple class="form-control" style="height: 150px;">
            {foreach from=$categories item=category}
              <option value="{$category.id_category}">{$category.name}</option>
            {/foreach}
          </select>
          <input type="hidden" name="type[categories]" value="CATEGORIES">
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

{block name='content'}
  <div class="panel">
    <h3>{$block_name} - {l s='Modifier l\'element' mod='okicustominfo'}</h3>

    <form method="post" action="{$link->getAdminLink('AdminOkiCustomInfoModifyItem')|escape:'html':'UTF-8'}" enctype="multipart/form-data">
      <input type="hidden" name="id_item" value="{$itemData.id_item|default:''}" />
      <input type="hidden" name="id_block" value="{$id_block}" />

      {* {$itemData|@print_r} *}
      {foreach from=$itemData key=name item=field}
        {if $name != "id_item" && $name != "id_block" && $name != "active" && $name != "position"
            && $name != "date_created" && $name != "date_updated"
        }
          {if $name == "image"}
            <div class="form-group d-flex">
              <label>{$name|replace:'_':' '|capitalize}</label>
              <input type="file" name="image" value="{$field}" class="form-control" />
            </div>
          {else}
            <div class="form-group d-flex">
              <label>{$name|replace:'_':' '|capitalize}</label>
              <input type="text" name="{$name}" value="{$field}" class="form-control" />
            </div>
          {/if}
        {/if}
      {/foreach}

      <div class="panel-footer">
        <a href="{$link->getAdminLink('AdminOkiCustomInfoItems')|escape:'html':'UTF-8'}&id_block={$id_block}" class="btn btn-secondary">
          <i class="material-icons">arrow_back</i> {l s='Retourner' d='Admin.Actions'}
        </a>
        <button type="submit" name="submit_modify_item" class="btn btn-primary pull-right">{l s='Sauvegarder' mod='okicustominfo'}</button>
      </div>
    </form>
  </div>
{/block}
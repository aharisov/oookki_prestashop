<div id="okicustominfo_listing" class="panel panel-default col-lg-12">
  <div class="panel-heading">
    {l s='Les éléments de l\'InfoBlock' mod='okicustominfo'} {$infoBlockName}

    <div class="panel-heading-action">
      <a id="desc-okicustominfo_blocks-new" class="list-toolbar-btn" href="{$link->getAdminLink('AdminOkiCustomInfoAddItem')|escape:'html':'UTF-8'}&id_block={$id_block}&from_items=Y">
        <span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="Ajouter" data-html="true" data-placement="top">
          <i class="process-icon-new"></i>
        </span>
      </a>
    </div>
  </div>
  <div class="panel-body">
    <div class="listing-table">
      <div class="listing-head row">
        <div class="col-lg-1 content-header">{l s='Position' mod='okicustominfo'}</div>
        {foreach from=$tableHeaders item=field}
          <div class="col-lg-2 content-header">{$field}</div>
        {/foreach}
        <div class="col-lg-2 content-header">{l s='Actions' mod='okicustominfo'}</div>
      </div>
    </div>
    <div id="sortable-list" class="listing-body">
      {foreach from=$items item=item}
        {* {$item|@print_r} *}
        <div class="listing-row row" data-id="{$item.id_item}" data-block="{$item.id_block}">
          <div class="col-lg-1 drag-handle">
            <i class="material-icons">drag_handle</i>
          </div>
          {foreach from=$tableHeaders item=field}
            <div class="col-lg-2">
              {if $field|replace:' ':'_'|lower == 'image'}
                {if empty($item[$field|replace:' ':'_'|lower])}
                  <i class="material-icons">hide_image</i>
                {else}
                  <a href="../{$item[$field|replace:' ':'_'|lower]}" target="_blank">
                    <img class="pic" src="../{$item[$field|replace:' ':'_'|lower]}" />
                  </a>
                {/if}
              {elseif $field|replace:' ':'_'|lower == 'show_logo'}  
                {if $item[$field|replace:' ':'_'|lower] == 1}
                  Oui
                {else}
                  Non
                {/if}
              {else}
                <p>{$item[$field|replace:' ':'_'|lower]}</p>
              {/if}
            </div>
          {/foreach}
          <div class="col-lg-3">
            <label class="switch-input {if $item.active}checked{/if}">
              <input type="checkbox" class="toggle-status" data-id="{$item.id_item}" data-block="{$id_block}" {if $item.active}checked{/if}>
            
              <span class="switch_text" style="">
                {if $item.active}
                  Activé
                {else}
                  Désactivé
                {/if}
              </span>
            </label>

            <div class="pull-right" style="padding: 0;">
              <!-- Modify Button -->
              <a href="{$link->getAdminLink('AdminOkiCustomInfoModifyItem')|escape:'html':'UTF-8'}&id_item={$item.id_item}&id_block={$smarty.get.id_block}" class="btn btn-warning btn-sm">
                <span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="Modifier" data-html="true" data-placement="top">
                  <i class="material-icons">edit</i>
                </span>
              </a>

              <!-- Delete Button -->
              <button class="btn btn-danger btn-sm delete-item" data-id="{$item.id_item}" data-block="{$id_block}">
                <span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="Supprimer" data-html="true" data-placement="top">
                  <i class="material-icons">delete</i>
                </span>
              </button>
            </div>
          </div>
        </div>
      {/foreach}
    </div>
    <div class="panel-footer">
      <a href="{$link->getAdminLink('AdminOkiCustomInfo')|escape:'html':'UTF-8'}&id_block={$id_block}" class="btn btn-secondary">
        <i class="material-icons">arrow_back</i> {l s='Retourner' d='Admin.Actions'}
      </a>
    </div>
  </div>
</div>

<script>
  var ajax_url = '{$link->getAdminLink("AdminOkiCustomInfoItems")|escape:'javascript'}';
  console.log("AJAX URL:", ajax_url); 
</script>

{if $page.page_name == 'checkout'}
  {assign var=num value=1}
  {* {assign var=title value='Récapitulatif'} *}
  {assign var="title" value="Mes données"}
  {assign var=icon value='<i class="fa-solid fa-gear"></i>'}
{/if}
<div class="order-current-step flex">
  <div class="content flex">
    <p class="sup-title">Étape <span>{$num}</span> / 5</p>
    <div class="title"></div>
  </div>
  <div class="icon-mobile">{$icon nofilter}</div>
</div>
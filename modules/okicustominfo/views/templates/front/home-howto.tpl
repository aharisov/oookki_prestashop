<div class="howto-block mb-common">
  <div class="cont">
    <div class="howto-list flex">
      {if $items}
        {foreach from=$items item=item}
          <div class="howto-item">
            <div class="pic"><img src="{$item.image}" alt="{$item.title}"></div>
            <div class="inner">
              <div class="title">{$item.title}</div>
              <div class="text">{$item.description}</div>
              <a href="{$item.url}" class="btn btn-black">{$item.button_title}</a>
            </div>
          </div>
        {/foreach}
      {/if}
    </div>
  </div>
</div>
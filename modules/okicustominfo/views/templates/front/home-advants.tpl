<section class="home-advants home-section mb-common">
  <div class="cont">
    <div class="section-head flex">
      {if $infoblock}
        <h2>{$infoblock.title}</h2>
      {/if}
    </div>
    <div class="advants-list flex">
      {if $items}
        {foreach from=$items item=item}
          <div class="advants-item">
            <div class="pic"><img src="{$item.image}" alt=""></div>
            <div class="inner">
              <div class="text">{$item.description}</div>
              <a href="{$item.url}" class="btn btn-black">{$item.button_title}</a>
            </div>
          </div>
        {/foreach}
      {/if}
    </div>
  </div>
</section>
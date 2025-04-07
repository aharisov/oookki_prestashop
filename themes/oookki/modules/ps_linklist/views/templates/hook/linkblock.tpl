{foreach $linkBlocks as $linkBlock}
  <div class="footer-menu">
    <h4>{$linkBlock.title}</h4>
    <ul id="footer_sub_menu_{$linkBlock.id}">
      {foreach $linkBlock.links as $link}
        <li>
          <a
              href="{$link.url}"
              title="{$link.description}"
              {if !empty($link.target)} target="{$link.target}" {/if}
          >
            {$link.title}
          </a>
        </li>
      {/foreach}
    </ul>
  </div>
{/foreach}
{* {$linkBlocks|@print_r} *}
{if count($linkBlocks) > 0 && $linkBlocks[0]["hook"] == "displayFooter"}
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
{/if}

{if count($linkBlocks) > 0 && $linkBlocks[0]["hook"] == "displayMainMenu"}
  <ul class="main-menu__inner flex">
    {foreach $linkBlocks as $linkBlock}
      {assign var="sorted_links" value=$linkBlock.links}
      <li class="main-menu__parent">
        <span>{$linkBlock.title}</span>
        <div class="main-menu__dropdown">
          <ul>
            {foreach $sorted_links as $link}
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
    </li>
    {/foreach}
  </ul>
{/if}

{if count($linkBlocks) > 0 && $linkBlocks[0]["hook"] == "displayShoppingCartFooter"}
  {foreach $linkBlocks as $linkBlock}
    <div class="footer-menu">
      <ul>
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
{/if}
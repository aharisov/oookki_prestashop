{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}
    {if $nodes|count}
      {* {$nodes|@print_r} *}
      <ul class="{if $depth == 0}main-menu__inner flex{/if}" {if $depth == 0}id="top-menu"{/if} data-depth="{$depth}">
        {foreach from=$nodes item=node}
            <li class="{if $node.children|count > 0}main-menu__parent{/if}" id="{$node.page_identifier}">
            {assign var=_counter value=$_counter+1}
              {if $node.depth == 1}
                <span class="{if $node.current} active {/if}">{$node.label}</span>
              {else}
                <a
                  href="{$node.url}" data-depth="{$depth}"
                  {if $node.open_in_new_window} target="_blank" {/if}
                >
                  {$node.label}
                </a>
              {/if}

              {if $node.children|count > 0}
                {if $node.depth == 1}<div class="main-menu__dropdown">{/if}
                {menu nodes=$node.children depth=$node.depth parent=$node}
                {if $node.depth == 1}</div>{/if}
              {/if}
            </li>
        {/foreach}
      </ul>
    {/if}
{/function}

{menu nodes=$menu.children}

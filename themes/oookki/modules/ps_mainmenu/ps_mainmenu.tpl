{assign var=_counter value=0}
{function name="menu" nodes=[] depth=0 parent=null}
    {if $nodes|count}
      <ul class="main-menu__inner flex" {if $depth == 0}id="top-menu"{/if} data-depth="{$depth}">
        {foreach from=$nodes item=node}
            <li class="{if $depth >= 0}main-menu__parent{/if}" id="{$node.page_identifier}">
            {assign var=_counter value=$_counter+1}
              <span class="{if $node.current} active {/if}">{$node.label}</span>

              {if $depth >= 0}
                <div class="main-menu__dropdown" id="top_sub_menu_{$_expand_id}">
                  <ul>
                    {if $node.children|count}
                      <li>
                        <a
                          href="{$node.url}" data-depth="{$depth}"
                          {if $node.open_in_new_window} target="_blank" {/if}
                        >
                          {menu nodes=$node.children depth=$node.depth parent=$node}
                        </a>
                      </li>  
                    {/if}
                  </ul>
                </div>
              {/if}
            </li>
        {/foreach}
      </ul>
    {/if}
{/function}

{menu nodes=$menu.children}
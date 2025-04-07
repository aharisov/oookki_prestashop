{extends file=$layout}

{block name='content'}
    {block name='page_header_container'}
      {block name='page_title' hide}
        <header class="page-header">
          <h1>{$smarty.block.child}</h1>
        </header>
      {/block}
    {/block}

    {block name='page_content_top'}{/block}

    {block name='page_content_container'}
        {block name='page_content'}
          <!-- Page content -->
        {/block}
    {/block}
{/block}

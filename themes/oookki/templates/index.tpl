{extends file='page.tpl'}

{block name='page_content_container'}
  {block name='breadcrumb'} {/block}

  {block name='page_content'}
    {block name='hook_home'}
      {hook h='displayHome'}
    {/block}
  {/block}
{/block}

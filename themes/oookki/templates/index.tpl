{extends file='page.tpl'}

{block name='page_content_container'}
  {block name='breadcrumb'} {/block}

  {block name='page_content'}
    {block name='hook_home'}
      {hook h='displayHome'}
      {hook h='displayOkiCustomInfo' id_block=3 template='home-howto'}
      {hook h='displayFeatured'}
      {hook h='displayOkiCustomInfo' id_block=1 template='home-advants'}
      {hook h='displayOkiCustomInfo' id_block=4 template='faq'}
    {/block}
  {/block}
{/block}

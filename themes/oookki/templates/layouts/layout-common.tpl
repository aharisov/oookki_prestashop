{include file='_partials/helpers.tpl'}

<!doctype html>
<html lang="{$language.locale}">

  <head>
    {block name='head'}
      {include file='_partials/head.tpl'}
    {/block}
  </head>

  <body id="{$page.page_name}" class="{$page.body_classes|classnames}">

    {block name='hook_after_body_opening_tag'}
      {hook h='displayAfterBodyOpeningTag'}
    {/block}

    <header class="flex">
      {block name='header'}
        {include file='_partials/header.tpl'}
      {/block}
    </header>

    <main>
      {block name='notifications'}
        {*include file='_partials/notifications.tpl'*}
      {/block}

      {hook h="displayWrapperTop"}
      
      {if $page.page_name != 'index'}
        {block name='breadcrumb'}
          {include file='_partials/breadcrumb.tpl'}
        {/block}
      {/if}
      
      {block name="left_column"}
        <div id="left-column" class="col-xs-12 col-md-4 col-lg-3">
          {if $page.page_name == 'product'}
            {hook h='displayLeftColumnProduct' product=$product category=$category}
          {else}
            {hook h="displayLeftColumn"}
          {/if}
        </div>
      {/block}

      {block name="content_wrapper"}
        <div id="content-wrapper" class="js-content-wrapper left-column right-column col-md-4 col-lg-3">
          {hook h="displayContentWrapperTop"}
          {block name="content"}
            <p>Hello world! This is HTML5 Boilerplate.</p>
          {/block}
          {hook h="displayContentWrapperBottom"}
        </div>
      {/block}

      {block name="right_column"}
        <div id="right-column" class="col-xs-12 col-md-4 col-lg-3">
          {if $page.page_name == 'product'}
            {hook h='displayRightColumnProduct'}
          {else}
            {hook h="displayRightColumn"}
          {/if}
        </div>
      {/block}
        
      {hook h="displayWrapperBottom"}
    </main>

    {block name='hook_footer_before'}
      {hook h='displayFooterBefore'}
    {/block}

    <footer id="footer" class="js-footer">
      {block name="footer"}
        {include file="_partials/footer.tpl"}
      {/block}
    </footer>

    {block name='javascript_bottom'}
      {include file="_partials/password-policy-template.tpl"}
      {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
    {/block}

    {block name='hook_before_body_closing_tag'}
      {hook h='displayBeforeBodyClosingTag'}
    {/block}
  </body>
</html>

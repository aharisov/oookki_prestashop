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

    <header class="order-header">
      {block name='header'}
        {include file='checkout/_partials/header-order.tpl'}
      {/block}
    </header>

    <main>
      {hook h="displayWrapperTop"}

      {block name="content_wrapper"}
        <div id="content-wrapper" class="cont js-content-wrapper">
          {hook h="displayContentWrapperTop"}
          {block name="content"}
            <p>Hello world! This is HTML5 Boilerplate.</p>
          {/block}
          {hook h="displayContentWrapperBottom"}
        </div>
      {/block}
        
      {hook h="displayWrapperBottom"}
    </main>

    <footer id="footer" class="order-footer js-footer">
      {block name="footer"}
        {include file="checkout/_partials/footer-order.tpl"}
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
{extends file='page.tpl'}

{block name='notifications'}{/block}

{block name='page_content_container'}
  <div class="profile-top">
    <div class="inner">
      <h2>Bonjour {$customer.firstname} !</h2>
      <p>Bienvenue dans votre espace OOOKKI !</p>
    </div>
  </div>
  <section id="content" class="page-content cont">
    {block name='breadcrumb'}
      {include file='_partials/breadcrumb.tpl'}
    {/block}

    {block name='page_title'}{/block}

    {block name='page_content_top'}
      {block name='customer_notifications'}
        {include file='_partials/notifications.tpl'}
      {/block}
    {/block}
    {block name='page_content'}
      <!-- Page content -->
    {/block}
  </section>

  {if $page.page_name == "my-account"}
    {if count($viewed_products) > 0}
      {include file='customer/_partials/viewed-products.tpl'}
    {/if}
  {/if}
{/block}

{* {block name='page_footer'}
  {block name='my_account_links'}
    {include file='customer/_partials/my-account-links.tpl'}
  {/block}
{/block} *}

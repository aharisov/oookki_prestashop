{extends file='page.tpl'}

 {block name='page_title'}
   {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
 {/block}
 
 {block name='page_content'}
  <div class="cont">
    <form class="restore-form auth-form">
      <div class="form-title">
        <i class="fa-solid fa-key"></i>
        <h1>{l s='Forgot your password?' d='Shop.Theme.Customeraccount'}</h1>
      </div>
      {foreach $successes as $success}
        <div class="form-note success">{$success}</div>
      {/foreach}
    </form>
  </div>
 {/block}
 
 {block name='page_footer'}
   <ul>
     <li><a href="{$urls.pages.authentication}">{l s='Back to Login' d='Shop.Theme.Actions'}</a></li>
   </ul>
 {/block}
 
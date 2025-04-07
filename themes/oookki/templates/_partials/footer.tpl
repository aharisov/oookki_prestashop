<div class="cont">
  <div class="footer-inner flex">
    {block name='hook_footer'}
      {hook h='displayFooter'}
    {/block}
  </div>

  <div class="footer-bot">
    <a href="/" class="footer-logo">
      <img src="{$urls.img_url}logo-white.svg" alt="OOOKKI">
    </a>

    {block name='hook_footer_after'}
      {hook h='displayFooterAfter'}
    {/block}
  </div>
</div>
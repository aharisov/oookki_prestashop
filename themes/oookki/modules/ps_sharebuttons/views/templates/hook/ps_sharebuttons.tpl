{block name='social_sharing'}
  {if $social_share_links}
    <div class="social-sharing">
      <span>{l s='Share' d='Shop.Theme.Actions'}</span>
      <ul>
        {foreach from=$social_share_links item='social_share_link'}
          <li class="{$social_share_link.class} icon-gray">
            <a href="{$social_share_link.url}" class="text-hide" title="{$social_share_link.label}" target="_blank" rel="noopener noreferrer">
              {if $social_share_link.class == "facebook"}  
                <i class="fa-brands fa-facebook-f"></i>
              {/if}
              {if $social_share_link.class == "twitter"}  
                <i class="fa-brands fa-twitter"></i>
              {/if}
              {if $social_share_link.class == "pinterest"}  
                <i class="fa-brands fa-pinterest-p"></i>
              {/if}
            </a>
          </li>
        {/foreach}
      </ul>
    </div>
  {/if}
{/block}

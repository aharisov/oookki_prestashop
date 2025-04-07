{block name='block_social'}
  <div class="socials flex">
    <div class="socials__label">Rejoignez-nous sur</div>
    <ul class="socials__list flex">
      {foreach from=$social_links item='social_link'}
        <li class="{$social_link.class}">
          <a href="{$social_link.url}" target="_blank" rel="noopener noreferrer">
            <i class="fa-brands fa-{$social_link.class}"></i>
          </a>
        </li>
      {/foreach}
    </ul>

    {block name='copyright_link'}
      <div class="copyright">&copy; OOOKKI 2025</div>
    {/block}
  </div>
{/block}

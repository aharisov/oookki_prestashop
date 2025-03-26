{if $logged}
  <a
    class="header-btn btn-profile"
    href="{$urls.pages.my_account}"
    title="{l s='Voir mon compte client' d='Shop.Theme.Customeraccount'}"
    rel="nofollow"
  >
    <i class="fa-solid fa-circle-user"></i>
    <span>{$customerName}</span>
  </a>
  <a
    class="logout header-btn"
    href="{$urls.actions.logout}"
    title="Déconnexion"
    rel="nofollow"
  >
    <i class="fa-solid fa-arrow-right-from-bracket"></i>
  </a>
{else}
  <a
    class="header-btn btn-login"
    href="{$urls.pages.authentication}?back={$urls.current_url|urlencode}"
    title="{l s='Connectez-vous à votre compte client' d='Shop.Theme.Customeraccount'}"
    rel="nofollow"
  >
    <i class="fa-regular fa-user"></i>
    <span>{l s='Sign in' d='Shop.Theme.Actions'}</span>
  </a>
{/if}

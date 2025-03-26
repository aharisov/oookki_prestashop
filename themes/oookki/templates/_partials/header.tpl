<div class="cont">
  <div class="header__inner flex">
    {renderLogo}

    {block name='header_search'}
      {hook h='displayTop'}
    {/block}

    {block name='header_right'}
      <div class="right flex">
        {include file='_partials/header-buttons.tpl'}
      </div>
    {/block}
  </div>

  {block name='header_nav'}
    <nav class="main-menu">
      {hook h='displayMainMenu'}  
    </nav>
  {/block}
</div>
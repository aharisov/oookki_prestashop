<div id="search_widget" class="search-widgets header__search" data-search-controller-url="{$search_controller_url}">
  <form method="get" action="{$search_controller_url}">
    <input type="hidden" name="controller" value="search">
    
    <input type="text" name="s" value="{$search_string}" placeholder="{l s='Search our catalog' d='Shop.Theme.Catalog'}" aria-label="{l s='Search' d='Shop.Theme.Catalog'}">
    <button type="submit" class="submit-search">
      <i class="fa-solid fa-magnifying-glass"></i>
    </button>

    <button type="reset" class="clear-search" aria-hidden="true">
      <i class="fa-solid fa-circle-xmark"></i>
    </button>
  </form>
</div>

<div class="modal price-details-modal in-cart-modal" id="in-cart-modal" tabindex="-1" role="dialog">
  <button class="modal-close js-modal-close" aria-label="Close"></button>

  <div class="modal-inner">
    <h4 class="modal-title">Ajouté au panier</h4>

    <div class="modal-product">
      {* {$product|@print_r} *}
      <div class="modal-picture">
        {if $image != null}
          <img src="{$image}" alt="{$product->name}">
        {else}
          <i class="fa-solid fa-image"></i>
        {/if}
      </div>
      <div class="right">
        <div class="name">{$product->name}{if $product->manufacturer_name}, {$product->manufacturer_name}{/if}</div>
        <div class="price">{$price}</div>
      </div>
    </div>

    <div class="modal-buttons flex">
      <a href="/panier?action=show" class="btn btn-red__empty">
        <i class="fa-solid fa-cart-shopping"></i>  
        Voir mon panier
      </a>
      <button class="btn btn-black continue modal-close" aria-label="Close">Continuer les achats</button>
    </div>

    {if isset($related) && count($related) > 0}
      {include file="catalog/_partials/products-related-modal.tpl" products=$related}
    {/if}

    {if isset($similar) && count($similar) > 0} 
      {include file="catalog/_partials/products-related-modal.tpl" products=$similar}
    {/if}
  </div>
</div>

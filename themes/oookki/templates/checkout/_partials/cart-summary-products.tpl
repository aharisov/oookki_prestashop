<div class="summary-block js-cart-summary-products">
  <h3 class="title">Votre panier</h3>  
  {* <p>{$cart.summary_string}</p> *}

  {* <p>
    <a href="#" data-toggle="collapse" data-target="#cart-summary-product-list" class="js-show-details">
      {l s='show details' d='Shop.Theme.Actions'}
      <i class="material-icons">expand_more</i>
    </a>
  </p> *}

  {block name='cart_summary_product_list'}
    <div class="summary-products" id="cart-summary-product-list">
      {foreach from=$cart.products item=product}
        <div class="summary-product">{include file='checkout/_partials/cart-summary-product-line.tpl' product=$product}</div>
      {/foreach}
    </div>
  {/block}
</div>

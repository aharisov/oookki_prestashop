<div class="product-top cat-{$product.id_category_default}">
  {block name='breadcrumb'}
    {include file='_partials/breadcrumb.tpl'}
  {/block}

  {if 3 != $product.id_category_default && 11 != $product.id_category_default}
    <div class="product-top__inner flex">
      <div class="product-top__name">{$product.name}</div>
      <div class="product-top__tabs">
        <div class="product-top__tabs-select">Présentation</div>
        <div class="product-top__tabs-switch">
          <button type="button" class="tab-button active" data-type="1" data-tab="product-info">Présentation</button>
          <button type="button" class="tab-button" data-type="2" data-tab="product-features" data-prod-id="{$product.id}">Caractéristiques</button>
          <button type="button" class="tab-button" data-type="3" data-tab="product-description" data-prod-id="{$product.id}">Description</button>
        </div>
      </div>
      <div class="product-top__price flex">
        <div class="info">
          {assign var="monthlySum" value=$product.price_amount/3}
          <span class="info-sum">{$product.price}</span>
          <i class="info-note">ou {$monthlySum|string_format:"%.2f"} €/mois</i>
        </div>

        <div class="buttons flex">
          {* <button type="button" class="btn btn-black__empty js-show-price" data-modal="price-details-modal">Détails du prix</button> *}
          <button type="button" class="btn btn-red  open-modal add-to-cart" 
            title="Ajouter au panier"
            data-id="{$product.id} "
            >
            <i class="fa-solid fa-basket-shopping"></i>
          </button>
        </div>
      </div>
    </div>
  {/if}
</div>
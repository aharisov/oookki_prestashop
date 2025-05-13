<div class="product-promo__wrap">
  <h3>Promotions sur ce produit</h3>
  <div class="product-promo">
    {foreach from=$product.features item="feature"}
      {if 14 == $feature.id_feature || 15 == $feature.id_feature}
        <div class="promo-item">
          <p>{$feature.name} : {$feature.value} €</p>
          {* <a href="https://mobile.free.fr/webpublic/odr_2fb968c22e.pdf" target="_blank">Télécharger le coupon</a> *}
        </div>
      {/if}
    {/foreach}
  </div>
</div>
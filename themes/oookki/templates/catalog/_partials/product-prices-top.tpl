{if $product.show_price}
  <div class="info product-prices js-product-prices">
    {assign var="monthlySum" value=$product.price_amount/3}
    <span class="info-sum">{$product.price}</span>
    {if 3 != $product.id_category_default && 11 != $product.id_category_default}
      <i class="info-note">ou {$monthlySum|string_format:"%.2f"} €/mois</i>
    {/if}
    {* {block name='product_discount'}
      {if $product.has_discount}
        <div class="product-discount">
          {hook h='displayProductPriceBlock' product=$product type="old_price"}
          <span class="regular-price">{$product.regular_price}</span>
        </div>
      {/if}
    {/block} *}
  </div>
{/if}

<div class="summary-product">
  <!--  product line left content: image-->
  <div class="product-pic">
    <a href="{$product.url}" target="_blank">
      {if $product.default_image}
        <picture>
          {if !empty($product.default_image.bySize.cart_default.sources.avif)}<source srcset="{$product.default_image.bySize.cart_default.sources.avif}" type="image/avif">{/if}
          {if !empty($product.default_image.bySize.cart_default.sources.webp)}<source srcset="{$product.default_image.bySize.cart_default.sources.webp}" type="image/webp">{/if}
          <img src="{$product.default_image.bySize.cart_default.url}" alt="{$product.name|escape:'quotes'}" loading="lazy">
        </picture>
      {else}
        <picture>
          {if !empty($urls.no_picture_image.bySize.cart_default.sources.avif)}<source srcset="{$urls.no_picture_image.bySize.cart_default.sources.avif}" type="image/avif">{/if}
          {if !empty($urls.no_picture_image.bySize.cart_default.sources.webp)}<source srcset="{$urls.no_picture_image.bySize.cart_default.sources.webp}" type="image/webp">{/if}
          <img src="{$urls.no_picture_image.bySize.cart_default.url}" loading="lazy" />
        </picture>
      {/if}
    </a>

    {if $product.has_discount}
      <div class="badges">
        {if $product.discount_type === 'percentage'}
          <span class="badge discount">
            -{$product.discount_percentage_absolute}
          </span>
        {else}
          <span class="badge discount">
            -{$product.discount_to_display}
          </span>
        {/if}
      </div>
    {/if}
  </div>

  <!--  product line body: label, discounts, price, attributes, customizations -->
  <div class="product-content">
    <div class="product-title">
      <a href="{$product.url}" target="_blank" data-id_customization="{$product.id_customization|intval}">{$product.name}</a>
    </div>

    {if count($product.attributes) > 0}
      <div class="product-props">
        {foreach from=$product.attributes key="attribute" item="value"}
          <div class="product-line-info {$attribute|lower}">
            <span class="label">{$attribute}:</span>
            <span class="value">{$value}</span>
          </div>
        {/foreach}
      </div>
    {/if}

    <div class="product-price-wrap">
      <div class="current-price">{$product.price}</div>
      {if $product.has_discount}
        <div class="old-price">{$product.regular_price}</div>
      {/if}
      
      {hook h='displayProductPriceBlock' product=$product type="unit_price"}
    </div>

    {if is_array($product.customizations) && $product.customizations|count}
      {block name='cart_detailed_product_line_customization'}
        {foreach from=$product.customizations item="customization"}
          <a href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
          <div class="modal fade customization-modal js-customization-modal" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}">
                    <span aria-hidden="true">&times;</span>
                  </button>
                  <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                </div>
                <div class="modal-body">
                  {foreach from=$customization.fields item="field"}
                    <div class="product-customization-line row">
                      <div class="col-sm-3 col-xs-4 label">
                        {$field.label}
                      </div>
                      <div class="col-sm-9 col-xs-8 value">
                        {if $field.type == 'text'}
                          {if (int)$field.id_module}
                            {$field.text nofilter}
                          {else}
                            {$field.text}
                          {/if}
                        {elseif $field.type == 'image'}
                          <img src="{$field.image.small.url}" loading="lazy">
                        {/if}
                      </div>
                    </div>
                  {/foreach}
                </div>
              </div>
            </div>
          </div>
        {/foreach}
      {/block}
    {/if}
  </div>

  <div class="product-summary item-summary">
    <div class="product-quantity flex">
      <div class="qty">
        <div class="input-group bootstrap-touchspin">
          <input
            class="js-cart-line-product-quantity input-group form-control"
            data-down-url="{$product.down_quantity_url}"
            data-up-url="{$product.up_quantity_url}"
            data-update-url="{$product.update_quantity_url}"
            data-product-id="{$product.id_product}"
            type="number"
            inputmode="numeric"
            pattern="[0-9]*"
            value="{$product.quantity}"
            name="product-quantity-spin"
            aria-label="{l s='%productName% product quantity field' sprintf=['%productName%' => $product.name] d='Shop.Theme.Checkout'}"
          />
          
          <div class="input-group-btn-vertical">
            <button class="btn-touchspin touchspin-up" type="button">
              <i class="fa-solid fa-angle-up"></i>
            </button>
            <button class="btn-touchspin touchspin-down" type="button">
              <i class="fa-solid fa-angle-down"></i>
            </button>
          </div>
        </div>
      </div>
      <div class="price">
        {if !empty($product.is_gift)}
          <span class="gift">{l s='Gift' d='Shop.Theme.Checkout'}</span>
        {else}
          {$product.total}
        {/if}
      </div>
    </div>
  </div>
  

  <div class="product-buttons flex cart-line-product-actions">
    <a
      class                       = "remove-from-cart delete"
      rel                         = "nofollow"
      href                        = "{$product.remove_from_cart_url}"
      data-link-action            = "delete-from-cart"
      data-id-product             = "{$product.id_product|escape:'javascript'}"
      data-id-product-attribute   = "{$product.id_product_attribute|escape:'javascript'}"
      data-id-customization       = "{$product.id_customization|default|escape:'javascript'}"
    >
      {if empty($product.is_gift)}
        <i class="fa-solid fa-trash-can"></i>
      {/if}
    </a>

    {block name='hook_cart_extra_product_actions'}
      {hook h='displayCartExtraProductActions' product=$product}
    {/block}
  </div>
</div>

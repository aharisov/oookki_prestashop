<div class="product-add-to-cart js-product-add-to-cart">
  {if !$configuration.is_catalog}
    {block name='product_quantity'}
      <div class="product-quantity">
        <div class="qty">
          <div class="input-group bootstrap-touchspin">
            <input 
              type="number" 
              name="qty" 
              id="quantity_wanted" 
              inputmode="numeric" 
              pattern="[0-9]*" 
              {if $product.quantity_wanted}
                value="{$product.quantity_wanted}"
                min="{$product.minimal_quantity}"
              {else}
                value="1"
                min="1"
              {/if} 
              class="input-group form-control" 
              aria-label="{l s='Quantity' d='Shop.Theme.Actions'}"
            >
            
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

        <div class="add">
          <button
            class="btn btn-red add-to-cart"
            data-button-action="add-to-cart"
            type="submit"
            {if !$product.add_to_cart_url || $product.availability == "unavailable"}
              disabled
            {/if}
            data-id-product={$product.id}
          >
            <i class="fa-solid fa-basket-shopping"></i>
            {l s='Add to cart' d='Shop.Theme.Actions'}
          </button>
        </div>
      </div>
    {/block}

    {block name='product_availability'}
      <div id="product-availability" class="product-availability js-product-availability {$product.availability}">
        {if $product.show_availability && $product.availability_message}
          <span>
          {if $product.availability == 'available'}
            <i class="fa-solid fa-check"></i>
          {elseif $product.availability == 'last_remaining_items'}
            <i class="fa-solid fa-hourglass-end"></i>
          {else}
            <i class="fa-solid fa-ban"></i>
          {/if}
          </span>
          {$product.availability_message}
        {/if}
      </div>
    {/block}

    {block name='product_minimal_quantity'}
      <p class="product-minimal-quantity js-product-minimal-quantity">
        {if $product.minimal_quantity > 1}
          {l
          s='The minimum purchase order quantity for the product is %quantity%.'
          d='Shop.Theme.Checkout'
          sprintf=['%quantity%' => $product.minimal_quantity]
          }
        {/if}
      </p>
    {/block}
  {/if}
</div>

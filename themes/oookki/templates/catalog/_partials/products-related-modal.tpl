<section class="section-products products-slider modal-recommend">
  <div class="">
    <div class="section-head flex">
      <h3>Recommandés avec votre article</h3>
    </div>

    <div class="swiper">
      <div class="swiper-wrapper">
        {foreach from=$products item="product" key="position"}
          {* {$product|@print_r} *}
          <div class="swiper-slide">
            <div class="product-card">
              <div class="top">
                <div class="pic">
                  <a href="{$product.url}">
                    {if $product.cover != null}
                      <img src="{$product.cover}" alt="{$product.name}">
                    {else}
                      <i class="fa-solid fa-image"></i>
                    {/if}
                    
                    {if !empty($product.flags)}
                      {* {$product.flags[0]|@print_r} *}
                      <div class="badges">
                        <div class="badge {$product.flags[0]['type']}">{$product.flags[0]['label']}</div>
                      </div>
                    {/if}
                  </a>
                </div>   
                <div class="right">
                  {if $product.brand}
                    <div class="brand"><a href="">{$product.brand}</a></div>
                  {/if}
                  <div class="name"><a href="{$product.url}">{$product.name}</a></div>
                </div> 
              </div>
              <div class="inner">
                <div class="price">
                  <div class="price-inner">
                    {if $product.old_price != null}   
                      <span>{$product.price}</span>
                      <span class="price-old">{$product.old_price}</span>
                    {else}
                      <span>{$product.price}</span>
                    {/if}
                  </div>
                </div>

                <button class="btn to-cart btn-red" data-id-product="{$product.id}" data-qty="1">
                  <i class="fa-solid fa-basket-shopping"></i>
                </button>
              </div>
            </div>
          </div>
        {/foreach}
      </div>
        
      <div class="swiper-pagination circle"></div>
      
      <div class="swiper-button-prev"></div>
      <div class="swiper-button-next"></div>
    </div>
  </div>
</section>
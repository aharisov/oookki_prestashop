{if !empty($subcategories)}
  {if (isset($display_subcategories) && $display_subcategories eq 1) || !isset($display_subcategories) }
    <nav class="section-nav mb-common">
      <div class="section-nav__list swiper">
        <div class="swiper-wrapper">
          {foreach from=$subcategories item=subcategory}
            <div class="swiper-slide">
              <div class="section-nav__item">
                <a href="{$subcategory.url}" title="{$subcategory.name|escape:'html':'UTF-8'}">
                  {if !empty($subcategory.image.large.url)}
                    <img 
                      src="{$subcategory.image.large.url}"
                      alt="{$subcategory.name|escape:'html':'UTF-8'}"
                      loading="lazy" />
                  {/if}
                  <span>{$subcategory.name|truncate:25:'...'|escape:'html':'UTF-8'}</span>
                </a>
              </div>
            </div>
          {/foreach}
        </div>
        <div class="swiper-pagination circle"></div>
      </div>
    </nav>
  {/if}
{/if}

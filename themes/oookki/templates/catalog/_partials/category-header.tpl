<div id="js-product-list-header">
  {get_brand_data assign=filtered_brand}
  {if $listing.pagination.items_shown_from == 1}
    <div class="block-category card card-block">
      <h1 class="h1">
        {$category.name}

        {if isset($filtered_brand) && 2 == $category.level_depth}
          {$filtered_brand.name}
        {/if}
      </h1>
      <div class="block-category-inner">
        {if $category.description}
          <div id="category-description" class="text-muted">{$category.description nofilter}</div>
        {/if}
        {* {if !empty($category.image.large.url)}
          <div class="category-cover">
            <picture>
              {if !empty($category.image.large.sources.avif)}<source srcset="{$category.image.large.sources.avif}" type="image/avif">{/if}
              {if !empty($category.image.large.sources.webp)}<source srcset="{$category.image.large.sources.webp}" type="image/webp">{/if}
              <img src="{$category.image.large.url}" alt="{if !empty($category.image.legend)}{$category.image.legend}{else}{$category.name}{/if}" loading="lazy" width="141" height="180">
            </picture>
          </div>
        {/if} *}
      </div>

      {if isset($filtered_brand) && 2 == $category.level_depth}
        <div class="cont">
          <div class="brand-description mb-common">
            <div class="logo">
              <img src="{$filtered_brand.image}" alt="{$filtered_brand.name}">
            </div>
            <div class="text">{$filtered_brand.description nofilter}</div>
          </div>
        </div>
      {/if}
    </div>
  {/if}
</div>

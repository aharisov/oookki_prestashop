{extends file=$layout}

{block name='head_microdata_special'}
  {include file='_partials/microdata/product-list-jsonld.tpl' listing=$listing}
{/block}

{block name='content'}
    <section id="products" class="section-products">
      {if $listing.products|count}
        {block name='product_list_active_filters'}
          {$listing.rendered_active_filters nofilter}
        {/block}

        {block name='product_list'}
          {include file='catalog/_partials/products.tpl' listing=$listing}
        {/block}

        {block name='product_list_bottom'}
          {include file='catalog/_partials/products-bottom.tpl' listing=$listing}
        {/block}

      {else}
        <div id="js-product-list" class="section-products__inner">
          {capture assign="errorContent"}
            <h4>{l s='No products available yet' d='Shop.Theme.Catalog'}</h4>
            <p>{l s='Stay tuned! More products will be shown here as they are added.' d='Shop.Theme.Catalog'}</p>
          {/capture}

          {include file='errors/not-found.tpl' errorContent=$errorContent}
        </div>
      {/if}
    </section>

    {block name='product_list_footer'}{/block}

    {hook h="displayFooterCategory"}
{/block}

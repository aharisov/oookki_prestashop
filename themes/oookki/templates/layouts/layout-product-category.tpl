{extends file='layouts/layout-common.tpl'}

{block name='content_wrapper'}
  {block name='top_slider'}
    {hook h='displayOkiCustomInfo' id_block=6 id_category=$category.id template='top-slider'}
  {/block}
  <div class="section-page">
    <div class="cont">
      {block name='breadcrumb'}
        {include file='_partials/breadcrumb.tpl'}
      {/block}
      {block name='product_list_header'}
        <h1>{$listing.label}</h1>
      {/block}
    </div>

    {block name='subcategory_list'}
      {if isset($subcategories) && $subcategories|@count > 0}
        {include file='catalog/_partials/subcategories.tpl' subcategories=$subcategories}
      {/if}
    {/block}

    {block name='product_list_top'}
      {include file='catalog/_partials/products-top.tpl' listing=$listing}
    {/block}
  
    <div class="section-inner mb-common">
      <div class="cont flex">
        {block name="left_column"}
          <div id="left-column" class="section-filter">
            <div class="section-filter__inner">
              {hook h="displayLeftColumn"}
            </div>
          </div>
        {/block}
        {block name='content'}
          <p>Hello world! This is HTML5 Boilerplate.</p>
        {/block}
      </div>
    </div>

   
    {hook h='displayOkiCustomInfo' id_block=7 id_category=$category.id template='faq'}
  
  </div>
{/block}
    
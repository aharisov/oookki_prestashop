{if isset($category.subcategories) && count($category.subcategories) > 0}
  <ul>
    <li>
      <label>
        <input type="checkbox" name="item[categories][]" value="{$category.id_category}" /> 
        {$category.name}
      </label>
      {foreach from=$category.subcategories item=subcategory}
        {include file="category_checkbox_tree.tpl" category=$subcategory}
      {/foreach}
    </li>
  </ul>
  {else}
    <div>
      <label>
        <input type="checkbox" name="item[categories][]" value="{$category.id_category}" />
        {$category.name}
      </label>
    </div>
  {/if}
  
{foreach from=$products item="product" key="position"}
	{* {$product|@print_r} *}
	{assign var="is_ok" value=false}

	{foreach from=$product.features item=feature}
		{if 13 == $feature["id_feature"] && 51 == $feature["id_feature_value"]}
			{assign var="is_ok" value=true}
		{/if}
	{/foreach}

	{if $is_ok}
		<div class="swiper-slide">
			{include file="catalog/_partials/miniatures/forfait-item.tpl" product=$product position=$position}
		</div>
	{/if}
{/foreach}

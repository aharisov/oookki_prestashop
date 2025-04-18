{foreach from=$products item="product" key="position"}
	<div class="swiper-slide">
		{include file="catalog/_partials/miniatures/product-card.tpl" product=$product position=$position}
	</div>
{/foreach}

{block name='product_miniature_item'}
	<div class="pack-item" data-id-product="{$product.id_product}">
		<h3 class="pack-item__title">{$product.name}</h3>
		{* {$product.features|@print_r} *}
		{foreach from=$product.features item="feature" key="position"}
			{if 7 == $feature["id_feature"]}
				<div class="pack-item__offer">{$feature.value}</div>
					<ul class="pack-item__specs">
			{else}
				{if 11 != $feature["id_feature"] && 13 != $feature["id_feature"]}
					<li class="{if 12 == $feature["id_feature"]}c{$product.features[4].value}{/if}">
						{$feature.value|regex_replace:"/\"(.*?)\"/":"<strong>$1</strong>" nofilter}
					</li>
				{/if}
			{/if}
		{/foreach}
		</ul>

		<div class="pack-item__price">
			<div class="num">{$product.price|regex_replace:"/,.*$/":""}</div>
			<div class="more">
					<span>€ {$product.price|regex_replace:"/^\d+\,(\d+).*/":"$1"}</span>
					<i>/ mois TTC</i>
			</div>
			<div class="note">{$product.features[6].value}</div>
		</div>
		<div class="pack-item__buttons">
			<a href="{$product.url}" class="btn btn-black__empty pack-item__link">Voir l’offre</a>
			<a href="#" class="btn btn-red js-open-modal" data-modal="pack-modal" data-id="1">Je souscris</a>
		</div>
	</div>
	{/block}
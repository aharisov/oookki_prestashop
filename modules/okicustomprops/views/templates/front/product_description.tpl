{* {$features|@print_r} *}
{$description nofilter}

<div class="description-inner">
  {foreach from=$blocks item="block"}
    <section class="description-section">
      <div class="text">
        {if $block.title}
          <h3>{$block.title}</h3>
        {/if}
        {if $block.text}
          <p>{$block.text}</p>
        {/if}
      </div>
      <div class="media">
        <figure>
          {if $block.video}
            <video controls="" name="media">
              <source src="{$block.video}" type="video/webm">
            </video>
          {/if}
          {if $block.image}
            <div class="cover">
              <img src="{$block.image}" alt="Couverture vidéo">
            </div>
          {/if}
        </figure>
      </div>
    </section>
  {/foreach}
</div>
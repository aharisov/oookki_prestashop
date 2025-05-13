{* {$colors|@print_r}
{$storage|@print_r} *}
{* {$custom_props|@print_r} *}
{if count($main_features) > 0}
  <div class="features-top flex">
    {foreach from=$main_features item="feature" key="id"}
      <div class="top-feature">
        <div class="icon">
          {if $id == 1}
            <i class="fa-solid fa-camera"></i>
          {/if}
          {if $id == 3}
            <i class="fa-solid fa-mobile-screen"></i>
          {/if}
          {if $id == 5}
            <i class="fa-solid fa-battery-three-quarters"></i>
          {/if}
        </div>
        <p>{$feature['name']}</p>
        <span>{$feature['value']}</span>
      </div>
    {/foreach}
  </div>
{/if}

<div class="features-inner">
  {if count($colors) > 0}
    <div class="feature-section">
      <div class="title">Couleurs disponibles</div>
      <ul class="list special">
        {foreach from=$colors item="color" key="name"}
          <li><span style="background: {$color.code}"></span> {$name}</li>
        {/foreach}
      </ul>
    </div>
  {/if}

  {if count($storage) > 0}
    <div class="feature-section">
      <div class="title">Stockages disponibles</div>
      <ul class="list special capacity">
        {foreach from=$storage item="storage_item"}
          <li>{$storage_item}</li>
        {/foreach}
      </ul>
    </div>
  {/if}

  {foreach from=$custom_props item=$group}
    <div class="feature-section">
      <div class="title">{$group.name}</div>
      {if count($group.props) > 0}
        <ul class="list">
          {foreach from=$group.props item=$prop}
            {* <li><span style="background: "></span> </li> *}
            <li {if empty($prop.value)}class="empty-prop"{/if}>
              <span>{$prop.name} :</span> 
              {if $prop.value}
                {$prop.value}
              {else}
                <i class="fa-solid fa-ban"></i>
              {/if}
            </li>
          {/foreach}
        </ul>
      {/if}
    </div>
  {/foreach}
</div>

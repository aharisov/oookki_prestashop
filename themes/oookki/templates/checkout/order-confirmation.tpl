{extends file=$layout}

{block name='content'}
  <section id="content-hook_order_confirmation" class="card">
    <div class="order-wrap order-finish-wrap flex">
      <div class="order-content personal-content">
        {block name='order_confirmation_header'}
          <div class="confirmation-wrap">
            <div class="confirmation-block">
              <h3>
                {l s='Your order is confirmed' d='Shop.Theme.Checkout'}
              </h3>
              <p>
                {l s='An email has been sent to your mail address %email%.' d='Shop.Theme.Checkout' sprintf=['%email%' => $order_customer.email]}
                {if $order.details.invoice_url}
                  {* [1][/1] is for a HTML tag. *}
                  {l
                    s='You can also [1]download your invoice[/1]'
                    d='Shop.Theme.Checkout'
                    sprintf=[
                      '[1]' => "<a href='{$order.details.invoice_url}'>",
                      '[/1]' => "</a>"
                    ]
                  }
                {/if}
              </p>

              {block name='hook_order_confirmation'}
                {$HOOK_ORDER_CONFIRMATION nofilter}
              {/block}
              <div class="pic"><i class="fa-solid fa-clipboard-check"></i></div>
            </div>
            <div class="confirmation-block">
              {if !$registered_customer_exists}
                {block name='account_transformation_form'}
                  <div class="card">
                    <div class="card-block">
                      {include file='customer/_partials/account-transformation-form.tpl'}
                    </div>
                  </div>
                {/block}
              {/if}
            </div>
            <div class="confirmation-block">
              <h3>Vous avez besoin d'autres choses ?</h3>
              <a href="/" class="btn btn-red">Commencer</a>
              <div class="pic"><i class="fa-solid fa-cart-shopping"></i></div>
            </div>
          </div>
        {/block}
      </div>
      <div class="cart-summary">
          {block name='order_confirmation_table'}
            {include
              file='checkout/_partials/order-confirmation-table.tpl'
              products=$order.products
              subtotals=$order.subtotals
              totals=$order.totals
              labels=$order.labels
              add_product_link=false
            }
          {/block}
        {* {hook h='displayReassurance'} *}
      </div>
    </div>
  </section>
{/block}


{block name='content'}
  

  {block name='hook_payment_return'}
    {if ! empty($HOOK_PAYMENT_RETURN)}
    <section id="content-hook_payment_return" class="card definition-list">
      <div class="card-block">
        <div class="row">
          <div class="col-md-12">
            {$HOOK_PAYMENT_RETURN nofilter}
          </div>
        </div>
      </div>
    </section>
    {/if}
  {/block}

  

  {block name='hook_order_confirmation_1'}
    {hook h='displayOrderConfirmation1'}
  {/block}

  {block name='hook_order_confirmation_2'}
    <section id="content-hook-order-confirmation-footer">
      {hook h='displayOrderConfirmation2'}
    </section>
  {/block}
{/block}

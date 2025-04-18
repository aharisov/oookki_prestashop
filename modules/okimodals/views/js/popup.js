$(document).on('click', '.open-modal', function (e) {
    e.preventDefault();
    const type = $(this).data('type');
    const id_product = $(this).data('id-product') || 0;
  
    $.get('/module/okimodals/popup', {
      type: type,
      id_product: id_product
    }).done(function (response) {
        console.info('cart update', response);
        if (response.modal) {
            $('body').append(response.modal);
            $('#in-cart-modal').modal('show');

            prestashop.on('updateCart', function (event) {
                const quantity = event.reason?.cart?.products_count;
            
                console.info('cart update', quantity);
                if (typeof quantity !== 'undefined') {
                // Update your cart counter
                document.querySelector('.header__buttons .btn-cart .cnt').textContent = quantity;
                }
            });
        }
    });
  });
  
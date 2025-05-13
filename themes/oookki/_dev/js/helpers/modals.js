$(function() {
  function closeModal(modal, btn) {
    $(btn).on('click', function (e) {
      modal.removeClass("show");
      $('.bg-modal').removeClass("show");
      $('body').removeClass("lock");

      setTimeout(function() {
        modal.remove();
      }, 500); 
    });
  }

  // add to cart with modal show
  $('.product-card .to-cart, .product-info .add-to-cart, .in-cart-modal .to-cart').on('click', function (e) {
    e.preventDefault();

    const idProduct = $(this).data('id-product');
    const quanInput = $('#quantity_wanted');
    let qtyProduct = $(this).data('qty') ? $(this).data('qty') : 1;

    if (quanInput) {
      qtyProduct = quanInput.val();
    }
    const modalType = 'add_to_cart';
    const btn = $(this);

    $(btn).attr('disabled', true);

    $.post(prestashop.urls.pages.cart, {
      ajax: 1,
      action: 'update',
      add: 1,
      id_product: idProduct,
      qty: qtyProduct,
      submitAddToCart: 1,
      dataType: 'json'
    })
      .done(function (response) {
        console.info('add res', response);
        if (response.hasError) {
          alert('Error adding to cart: ' + response.errors.join(', '));
        } else {
          const data = JSON.parse(response);
          const quantity = data?.cart.products_count;

          $(btn).attr('disabled', false);
          if (btn.hasClass('to-cart')) {
            $(btn).html('<i class="fa-solid fa-cart-plus"></i>');
          }
          
          if (btn.hasClass('in-cart-recommend')) {
            // prestashop.emit('updateCart', {
            //   response,
            // });
            location.reload();
          }
          
          if (quanInput) {
            quanInput.val(1);
          }
          
          // Fetch the modal content from the module
          $.get('/module/okimodals/popup', {
            type: modalType,
            id_product: idProduct
          }).done(function (res) {
            console.info('modal', res);
            if (res.modal) {
              $('body').append(res.modal);
              $('body').addClass('lock');
              
              setTimeout(function() {
                $('.bg-modal').addClass('show');
                $('.in-cart-modal').addClass('show');
              }, 200); 

              window.oookkiTheme.modalRecommendSlider();
              
              if (typeof quantity !== 'undefined') {
                document.querySelector('.header__buttons .btn-cart .cnt').textContent = quantity;
              }

              closeModal($('.in-cart-modal'), $('.in-cart-modal .modal-close'));
            }
          })
          .fail(function (xhr) {
            console.error('Error fetching modal:', xhr);
          });
        }
      })
      .fail(function (xhr) {
        console.error('Error adding to cart:', xhr);
      });
  });  

})
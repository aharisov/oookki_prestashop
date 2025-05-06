// change product quantity in cart or delete it
function updateCartQuantity(url, wrapper) {
    const requestData = {
        ajax: '1',
        action: 'update',
    };

    $.ajax({
        url: url,
        method: 'POST',
        data: requestData,
        dataType: 'json',
    })
        .then((resp) => {
            console.info('update', resp, resp.quantity);
            
            if (!resp.errors) {
                // if ($wrapper != null) {
                //     $(wrapper).closest('.product-quantity').find('.err').remove();
                //     const $err = $(`<p class="err">${resp.errors}</p>`);
                //     $(wrapper).closest('.product-quantity').append($err);
                // }
                $('#notifications .container').html('');
            } else {
                $('#notifications .container').html('');
                $('#notifications .container').append(`<div class="alert alert-danger">${resp.errors}</div>`);
            }
            $('.btn-cart .cnt').text(resp.cart.products_count);
            prestashop.emit('updateCart', {
                resp,
            });
        })
        .fail((resp) => {
            prestashop.emit('handleError', {
                eventType: 'updateProductInCart',
                resp,
            });
        });
}

function initCartBtns() {
    $('.item-summary .btn-touchspin').off('click').on('click', function (e) {
        e.preventDefault();
    
        const $button = $(this);
        const $wrapper = $button.closest('.bootstrap-touchspin');
        const $input = $wrapper.find('.js-cart-line-product-quantity');
        const productId = $input.data('product-id');
        const currentQty = parseInt($input.val()) || 1;
        const isUp = $button.hasClass('touchspin-up');
        const url = isUp ? $input.data('up-url') : $input.data('down-url');
        const newQty = isUp ? currentQty + 1 : Math.max(1, currentQty - 1);
    
        console.info(productId, newQty, $button.hasClass('touchspin-up'), url);
        updateCartQuantity(url, $wrapper);
    });
}

function initDeleteBtns() {
    $('.page-cart .remove-from-cart').off('click').on('click', function (e) {
        e.preventDefault();
    
        const url = $(this).attr('href');
    
        updateCartQuantity(url, '');
    });
}

$(function() {
    prestashop.on('updatedCart', function (event) {
        console.info('event', event);
        initCartBtns();
        initDeleteBtns();
    });

    initCartBtns();
    initDeleteBtns();
})
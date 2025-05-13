import $ from 'jquery';
import prestashop from 'prestashop';

function initProductSpin() {
  var $quanInput = $('#quantity_wanted');
  var $plus = $('.product-quantity .touchspin-up');
  var $minus = $('.product-quantity .touchspin-down');

  $plus.on('click', function () {
    var current = parseInt($quanInput.val()) || 1;
    $quanInput.val(current + 1);
    $quanInput.trigger('change');
  });

  $minus.on('click', function () {
    var current = parseInt($quanInput.val()) || 1;
    if (current > 1) {
      $quanInput.val(current - 1);
    }
    $quanInput.trigger('change');
  });

  $quanInput.on('focusout', () => {
    if ($quanInput.val() === '' || $quanInput.val() < $quanInput.attr('min')) {
      $quanInput.val($quanInput.attr('min'));
      $quanInput.trigger('change');
    }
  });

  $('body').on('change keyup', $quanInput, (e) => {
    // console.info('update info', e);
    if ($quanInput.val() !== '') {
      prestashop.emit('updateProduct', {
        eventType: 'updatedProductQuantity',
        event: e,
      });
    }
  });
}

$(function() {
  prestashop.on('updatedProduct', function (event) {
    let priceHtml = $('.current-price .current-price-value').text();
    let priceRaw = parseInt($('.product-prices').attr('content'));

    $('.product-top__price .info-sum').html(priceHtml);
    $('.product-top__price .info-note').html(`ou ${(priceRaw/3).toFixed(2)} €/mois`);
  });

  initProductSpin();
});
function changeProductCombinations() {
    $('.product-option').on('click', function () {
        const productId = $(this).data('product');
        const storage = $(this).data('storage');
        let productCard = $(this).closest('.product-card');
        let buttonParent = $(this).closest('ul');

        $(buttonParent).find('.product-option').removeClass('checked');
        $(this).addClass('checked');

        $.ajax({
            url: window.location.href,
            type: 'POST',
            data: {
                ajax: 1,
                action: 'getCombinationsForStorage',
                id_product: productId,
                storage: storage
            },
            dataType: 'json',
            success: function(result){
                // console.info(result);
                let productColors = $(productCard).find('.colors .color');
                
                productColors.each(function() {
                    let colorName = $(this).attr('aria-label').trim();
                    let productPrice = result.data[colorName].price;
                    let productPriceMonthly = parseInt(result.data[colorName].price_raw) / 3;
                    let productOldPrice = result.data[colorName].price_original;
                    let productQty = result.data[colorName].qty;

                    if (productQty == 0) {
                        $(this).addClass('not-in-stock');
                    } else {
                        $(this).removeClass('not-in-stock');
                    }

                    $(productCard).find('.price-inner span').text(productPrice);
                    $(productCard).find('.price-credit span i').text(Math.round((productPriceMonthly + Number.EPSILON) * 100) / 100);

                    if (productOldPrice != null) {
                        $(productCard).find('.price-inner .price-old').text(productOldPrice);
                    }
                })
            },
            error: function(xhr, status, error) {
                console.error('AJAX Error:', status, error);
                console.log('Response:', xhr.responseText);
            }
        });
    })
}

changeProductCombinations();

(window).oookkiTheme = (window).oookkiTheme || {};
(window).oookkiTheme.changeProductCombinations = changeProductCombinations;
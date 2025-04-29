function getProductProps(productId, tab, action) {
    // console.warn('ajax props');
    $.ajax({
        url: prestashop.urls.base_url + 'module/okicustomprops/ajax',
        type: 'POST',
        data: {
            'ajax': true,
            'action': `${action}`,
            'id_product': productId
        },
        dataType: 'json',
        success: function(res) {
            // console.info('props', res, tab);
            $(`#${tab}`).html(res.html);
            window.oookkiTheme.playVideo();
        },
        error: function(xhr, status, error) {
            console.error('Error:', error, xhr, status);
        }
    });
}

function initTabs() {
    const $tabButtons = $(".tab-button");
    const $tabPanels = $(".tab-panel");
    const $tabSelect = $(".product-top__tabs-select");
    const $tabSwitch = $(".product-top__tabs-switch");
  
    function activateTab(tabId) {
      $tabButtons.each(function () {
        const $btn = $(this);
        $btn.toggleClass("active", $btn.data("tab") === tabId);
      });
  
      $tabPanels.each(function () {
        const $panel = $(this);
        if ($panel.attr("id") === tabId) {
          $panel.attr("aria-hidden", "false");
  
          // Scroll to panel with offset
          const offset = 150;
          const panelTop = $panel.offset().top - offset;

          // console.info('panel offset', $panel.offset().top);
  
          if ($panel.offset().top < 250) {
            $("html, body").animate({ scrollTop: panelTop }, 400);
          }
        } else {
          $panel.attr("aria-hidden", "true");
        }
      });
  
      // Update select text on mobile
      const $activeButton = $(`[data-tab="${tabId}"]`);
      if ($tabSelect.length && $activeButton.length) {
        $tabSelect.text($activeButton.text()).removeClass("active");
      }
    }
  
    // Tab button click
    $tabButtons.on("click", function () {
      const tab = $(this).data("tab");
      const tabId = $(this).data("type");
      const productId = $(this).data("prod-id");
      if (tab) {
        activateTab(tab);
  
        if (tabId == '2') {
            getProductProps(productId, tab, 'getAjaxProductProps'); 
        }

        if (tabId == '3') {
            getProductProps(productId, tab, 'getAjaxProductDescrProps'); 
        }
  
        $tabSwitch.removeClass("open");
        $tabSelect.removeClass("active");
      }
    });
  
    // Toggle mobile tab menu
    $tabSelect.on("click", function () {
      $tabSwitch.toggleClass("open");
      $tabSelect.toggleClass("active");
    }); 
}

$(function(){
    initTabs();
})
  
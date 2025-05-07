function changePersonalTabs() {
    $('.order-info-nav .nav-link').on('click', function (e) {
        e.preventDefault();
    
        const $this = $(this);
        const target = $this.attr('href');
    
        // Deactivate all nav items and tab panes
        $('.order-info-nav .nav-item').removeClass('active');
        $('.tab-pane').attr('aria-hidden', true);
        $('.tab-page').attr('aria-expanded', false);
        $('.tab-pane').removeClass('active');
    
        // Activate clicked nav item
        $this.closest('.nav-item').addClass('active');
    
        // Show corresponding tab pane
        $(target).addClass('active');
        $(target).attr('aria-hidden', false);
        $(target).attr('aria-expanded', true);
    });
}

$(function(){
    changePersonalTabs();

    $('[data-link-action="sign-in"]').on('click', function (e) {
        e.preventDefault();
        console.info('sign-in in process');
        // Manually submit the login form
        $('#login-form').trigger('submit');
    });

    $('[data-link-action="register-new-customer"]').on('click', function (e) {
        e.preventDefault();
        console.info('new customer order in process');
        // Manually submit the login form
        $('#customer-form').trigger('submit');
    });
})
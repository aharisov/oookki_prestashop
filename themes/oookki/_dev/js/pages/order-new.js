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

function changeCurrentStepInfo(stepNum, stepName, stepIcon) {
    $('.order-current-step .sup-title span').text(stepNum);
    $('.order-current-step .title').text(stepName);
    $('.order-current-step .icon-mobile').html(`<i class="${stepIcon}"></i>`);
}

function setCurrentHeaderStep(stepId) {
    let step = $(`.order-step[data-step-id="${stepId}"]`);
    let stepNum = $(step).attr('data-step');
    let stepName = $(step).attr('data-step-name');
    let stepIcon = $(step).attr('data-icon');

    $('.order-steps .order-step').removeClass('current');
    $(this).removeClass('ready');
    $(this).addClass('current');
    changeCurrentStepInfo(stepNum, stepName, stepIcon);
}

function changeHeaderStepActivity() {
    let stepsMenu = $('.order-steps .order-step');

    stepsMenu.each(function() {
        let stepId = $(this).attr('data-step-id');
        let stepNum = $(this).attr('data-step');
        let stepName = $(this).attr('data-step-name');
        let stepIcon = $(this).attr('data-icon');
        let isCompleteStep = $(`#${stepId}`).hasClass('-complete');
        let isCurrentStep = $(`#${stepId}`).hasClass('-current');

        if (isCompleteStep) {
            $(this).addClass('ready');
        }
        if (isCurrentStep) {
            $(this).addClass('current');
            changeCurrentStepInfo(stepNum, stepName, stepIcon);
        }
    })
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

    $('.prev-step').on('click', function (e) {
        e.preventDefault();
        let prevStepId = '#'+$(this).attr('data-prev-step');
        
        if (prevStepId) {
            console.info('prev step id', prevStepId);
            setCurrentHeaderStep($(this).attr('data-prev-step'));
            $(prevStepId).trigger('click');
        }
    });

    changeHeaderStepActivity();
})
declare var Swiper: any;

document.addEventListener('DOMContentLoaded',  function(event) {
    const homeTopSlider = new Swiper('.top-slider', {
        speed: 800,
        // autoplay: {
        //     delay: 8000,
        // },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });

    const homePackSlider = new Swiper(".packs-list .swiper", {
        speed: 600,
        slidesPerView: 1,
        spaceBetween: 20,
        breakpoints: {
            768: {
                slidesPerView: 2,
            },
            1024: {
                slidesPerView: 3,
            },
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
    });

    const homeProductsSlider = new Swiper(".products-slider.swiper", {
        speed: 600,
        slidesPerView: 1,
        spaceBetween: 20,
        autoHeight: true,
        breakpoints: {
            640: {
                slidesPerView: 2,
            },
            1024: {
                slidesPerView: 4,
            },
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });

    const sectionNav = new Swiper(".section-nav .swiper", {
        speed: 600,
        slidesPerView: 1,
        spaceBetween: 20,
        breakpoints: {
            550: {
                slidesPerView: 2,
            },
            1024: {
                slidesPerView: 5,
            },
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
    });

    const recommendSlider = new Swiper(".recommend-slider.swiper", {
        speed: 600,
        slidesPerView: 1,
        spaceBetween: 20,
        autoHeight: true,
        breakpoints: {
            640: {
                slidesPerView: 2,
            },
            800: {
                autoHeight: false,
                slidesPerView: 3,
            },
            1200: {
                autoHeight: false,
                slidesPerView: 4,
            },
            1360: {
                autoHeight: false,
                slidesPerView: 5,
            },
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });

    const modalRecommendSlider = new Swiper(".modal-recommend .swiper", {
        speed: 600,
        slidesPerView: 1,
        spaceBetween: 20,
        autoHeight: true,
        mousewheel: {
            enabled: true,
        },
        breakpoints: {
            640: {
                slidesPerView: 2,
            },
            768: {
                direction: "vertical",
                slidesPerView: "auto",
            },
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });

    const productImagesSlider = new Swiper(".product-page__slider .swiper", {
        speed: 600,
        slidesPerView: 1,
        spaceBetween: 0,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
    });

    const orderPackSlider = new Swiper(".packs-list-modal .swiper", {
        speed: 600,
        slidesPerView: 1,
        spaceBetween: 19,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
    });

    const plansPhonesSlider = new Swiper(".phones-with-plans .swiper", {
        speed: 600,
        slidesPerView: 1,
        spaceBetween: 20,
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        /*
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },*/
    });
});
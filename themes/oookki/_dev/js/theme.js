import prestashop from 'prestashop';
import EventEmitter from 'events';

window.oookkiTheme = window.oookkiTheme || {};

import '@fortawesome/fontawesome-free/js/all.js';
// import './lib/photoswipe-lightbox.esm.min';
// import './lib/photoswipe.esm.min';
// import Swiper from 'swiper/bundle';

import './prestashop/selectors';

// import './responsive';
// import './checkout';
// import './customer';
import './prestashop/listing';
// import './product';
// import './cart';
import './prestashop/combinations';

import './helpers/add-to-cart';
import './helpers/api-get-product';
import './helpers/helpers';
import './helpers/plan-abon-switch';
import './helpers/play-video';
import './helpers/region-country-lists';
import './helpers/remove-from-cart';
import './helpers/reveal-on-scroll';
import './helpers/show-more-items';

import './components/forms';
import './components/input-mask';
import './components/main-menu';
import './components/move-element';
import './components/open-modal';
import './components/sliders';
import './components/sticky-element';
import './components/sticky-sidebar';

import './pages/compare-page';
import './pages/order-plan-change';
import './pages/order';
import './pages/product-compare';
import './pages/product-filter';
import './pages/product-payment';
import './pages/product-photo-change';
import './pages/product-sort';
import './pages/product-tabs';
import './pages/user-profile';

/* eslint-enable */

// "inherit" EventEmitter
// eslint-disable-next-line
for (const i in EventEmitter.prototype) {
  prestashop[i] = EventEmitter.prototype[i];
}

console.info('theme loqded', window.oookkiTheme);
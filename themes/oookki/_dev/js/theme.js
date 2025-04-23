import prestashop from 'prestashop';
import EventEmitter from 'events';

window.oookkiTheme = window.oookkiTheme || {};

import '@fortawesome/fontawesome-free/js/all.js';
// import 'expose-loader?exposes=Tether!tether';
// import 'bootstrap/dist/js/bootstrap.min';
// import 'bootstrap-touchspin';

import './prestashop/selectors';

// import './responsive';
// import './checkout';
// import './customer';
import './prestashop/listing';
// import './prestashop/product';
import './prestashop/cart';
import './prestashop/block-cart';
import './prestashop/combinations';
import './prestashop/product-custom';

// import './helpers/add-to-cart';
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

import './helpers/modals';
/* eslint-enable */

// "inherit" EventEmitter
// eslint-disable-next-line
for (const i in EventEmitter.prototype) {
  prestashop[i] = EventEmitter.prototype[i];
}
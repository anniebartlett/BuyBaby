// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

//= require jquery
//= require jquery_ujs

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import "../components/cart.js";
import { expandableSearchBar } from "../plugins/expandable_searchbar";
import { initStarRating } from "../plugins/init_star_rating";
import { initSweetalert } from "../plugins/init_sweetalert";
import { initMapbox } from "../plugins/init_mapbox";

import "mapbox-gl/dist/mapbox-gl.css";
import "@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css";
import mapboxgl from "mapbox-gl/dist/mapbox-gl.js";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  initStarRating();
  expandableSearchBar();
  initSweetalert('#sweet-alert-demo', {
    title: "Are you sure?",
    text: "This item will be deleted from your basket.",
    icon: "warning"

  }, (value) => {

    if (value) {
      const link = document.querySelector('#delete-link');
      link.click();
    }
  })
   initMapbox();
});
 // flatpickr(".datepicker", {});
  // flatpickr(".datepicker", {});


  // initSweetalert("#sweet-alert-demo", {
  //   title: "A nice alert",
  //   text: "This is a great alert, isn't it?",
  //   icon: "success",
  // });
  // Call your functions here, e.g:
  // initSelect2();

  // $(".carousel").carousel();


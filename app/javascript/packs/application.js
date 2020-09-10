// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
//= require jquery.lettering-0.6.1.min
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
import { initStarRating } from "../plugins/init_star_rating";
import { initSweetalert } from "../plugins/init_sweetalert";
import { initMapbox } from "../plugins/init_mapbox";
import { expandableSearchBar } from "../components/expandable_searchbar";
// import { initMapbox } from "../init/mapbox.js";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener("turbolinks:load", () => {
  initStarRating();
  initMapbox();

  flatpickr(".datepicker", {});

  initSweetalert("#sweet-alert-demo", {
    title: "A nice alert",
    text: "This is a great alert, isn't it?",
    icon: "success",
  });
  expandableSearchBar();
  // Call your functions here, e.g:
  // initSelect2();
  $(".carousel").carousel();
});

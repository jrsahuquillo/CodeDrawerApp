"use strict";

var _jquery = _interopRequireDefault(require("jquery"));

require("bootstrap");

require("./src/application.scss");

require("select2");

require("select2/dist/css/select2.css");

require("bootstrap4-toggle/css/bootstrap4-toggle.min.css");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("@rails/ujs").start();

require("turbolinks").start();

require("@rails/activestorage").start();

require("channels");

require("bootstrap/dist/js/bootstrap");

require("bootstrap4-toggle"); // jquery


global.$ = _jquery["default"];
global.jQuery = _jquery["default"];

require('jquery-ui'); // jquery-ui theme
// require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.css/ );
// require.context('file-loader?name=[path][name].[ext]&context=node_modules/jquery-ui-dist!jquery-ui-dist', true,    /jquery-ui\.theme\.css/ );


require("packs/custom/global");

require("packs/custom/drawers");

require("packs/custom/codetools");

require("packs/custom/notifications");

require("packs/custom/favorites"); // Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
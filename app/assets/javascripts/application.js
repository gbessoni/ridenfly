// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require underscore
//= require backbone

//= require moment
//= require bootstrap-datetimepicker
//= require pickers

//= require ridenfly
//= require_tree ./libs
//= require ./controllers/base
//= require_tree ./controllers
//= require_tree ./views

//= require_self

$(document).on('ready', function() {
  Ridenfly.initialize()
});

$(document).on('page:load', function() {
  Ridenfly.initialize()
});

// $(document).on('ready page:change', function() {
//   $('.datepicker').datetimepicker({
//       direction: 'bottom',
//       pickTime: false
//   });
// });

// $(document).on('ready page:change', function() {
//   $('.timepicker').datetimepicker({
//       direction: 'bottom',
//       pickDate: false,
//       pickSeconds: false
//   });
// });

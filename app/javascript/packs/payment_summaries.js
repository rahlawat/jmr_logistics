// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
var update_freight1;

update_freight1 = function() {
  var kanta, rate1, total, weight;
total = 0;
kanta = $('.kanta').val();
weight = $('.weight').val();
rate1 = $('.rate1').val();
if (!!kanta && !!weight) {
  total = (parseFloat(weight).toFixed(2) * parseFloat(rate1).toFixed(2)) + +parseFloat(kanta).toFixed(2);
  $('.freight1').val(total.toString());
}
};

$(document).on('turbolinks:load', function() {
  $('.kanta').on('change', function() {
  update_freight1();
});
$('.weight').on('change', function() {
  update_freight1();
});
});
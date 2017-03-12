# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#search_by').change ->
    search_by = $(this).val()
    if search_by == "Truck Number"
      $('.truck-number').removeClass('hidden')
      $('.search-by-range').addClass('hidden')
    if search_by == "G R Entry"
      $('.truck-number').addClass('hidden')
      $('.search-by-range').removeClass('hidden')
    return
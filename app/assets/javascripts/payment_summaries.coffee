# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
update_freight1 = ->
  total = 0
  kanta = $('.kanta').val()
  weight = $('.weight').val()
  rate1 = $('.rate1').val()
  if !!kanta and !!weight
    total = (weight * rate1) + kanta
    $('.freight1').val ""
    $('.freight1').val total
  return
$(document).ready ->
  $('.kanta').on 'change', ->
    update_freight1()
    return
  $('.weight').on 'change', ->
    update_freight1()
    return
  return
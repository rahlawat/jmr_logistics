# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  if $('#payment_receipt_party_code').val()
    url = '/parties/party_by_code/' + $('#payment_receipt_party_code').val()
    $.get url, (data) ->
      console.log(data)
      if data
        $('.party-name').html data.party_name
      else
        $('.party-name').html "No party found with this code."
      return
    return

  $('#payment_receipt_party_code').blur ->
    party_code = $(this).val()
    url = '/parties/party_by_code/' + party_code
    $.get url, (data) ->
      console.log(data)
      if data
        $('.party-name').html data.party_name
      else
        $('.party-name').html "No party found with this code."
      return
    return
  return

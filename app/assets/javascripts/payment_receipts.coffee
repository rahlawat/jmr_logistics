
$(document).on 'turbolinks:load', ->
  if $('#payment_receipt_mode_of_payment').val() == 'Cheque'
    $('.cheque-details').removeClass('hidden');
  else
    $('.cheque-details').removeClass('hidden').addClass('hidden');

  $('#payment_receipt_mode_of_payment').on 'change', ->
    if $(this).val() == 'Cheque'
      $('.cheque-details').removeClass('hidden');
    else
      $('.cheque-details').removeClass('hidden').addClass('hidden');
    return
  return



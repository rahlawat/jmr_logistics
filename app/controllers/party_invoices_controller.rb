require 'pry'
class PartyInvoicesController < ApplicationController
  before_action :authenticate_user!
  def index
    @party_invoices = PartyInvoice.order(:invoice_number).page params[:page]
  end

  def show
    @party_invoice = PartyInvoice.find(params[:id])
  end

  def destroy
    @party_invoice = PartyInvoice.find(params[:id])
    updated_party_invoice = @party_invoice.dup
    invoice_bills = @party_invoice.bills.collect { |child| child.clone }
    @party_invoice.bills = []
    updated_party_invoice.bills = invoice_bills
    updated_party_invoice.invoice_date = nil
    updated_party_invoice.invoice_generated  = false
    updated_party_invoice.invoice_number = params[:party_invoice][:invoice_number]
    if updated_party_invoice.save
      updated_party_invoice.bills.each { |bill|
        bill.bill_number = updated_party_invoice.invoice_number
        bill.save
      }
      @party_invoice.cancel_invoice(params[:party_invoice][:reason_for_cancellation], updated_party_invoice)
      redirect_to @party_invoice
    else
      flash.now[:error] = "Could not create new party invoice."
      render 'show' and return
    end
  end
end

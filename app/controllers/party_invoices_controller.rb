require 'pry'
class PartyInvoicesController < ApplicationController
  before_action :authenticate_user!
  def index
    @party_invoices = PartyInvoice.order(:invoice_number).page params[:page]
  end

  def show
    @party_invoice = PartyInvoice.find(params[:id])
  end

  def unlock
    @party_invoice = PartyInvoice.find(params[:id])
    @party_invoice.invoice_generated = false
    if @party_invoice.save
      redirect_to @party_invoice
    else
      flash.now[:error] = "Something went wrong"
      redirect_to @party_invoice
    end
  end
end

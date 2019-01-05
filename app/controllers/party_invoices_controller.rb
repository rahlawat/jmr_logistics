class PartyInvoicesController < ApplicationController
  def index
    @party_invoices = PartyInvoice.order(:invoice_number).page params[:page]
  end

  def show
    @party_invoice = PartyInvoice.find(params[:id])
  end
end

class PartyInvoicesController < ApplicationController
  def index
    @party_invoices = PartyInvoice.order(:invoice_number).page params[:page]
  end
end

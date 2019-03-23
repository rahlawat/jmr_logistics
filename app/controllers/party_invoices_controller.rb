class PartyInvoicesController < ApplicationController
  before_action :authenticate_user!
  def index
    @party_invoices = PartyInvoice.order(:invoice_number).page params[:page]
  end

  def show
    @party_invoice = PartyInvoice.find(params[:id])
  end
end

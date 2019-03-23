require 'pry'
class DownloadsController < ApplicationController
  before_action :authenticate_user!
  def show
    respond_to do |format|
      format.pdf { send_invoice_pdf }
      if Rails.env.development?
        format.html { render_sample_html }
      end
    end
  end

  def party_invoice_show
    respond_to do |format|
      format.pdf { send_party_invoice_pdf }
      if Rails.env.development?
        format.html { render_sample_html }
      end
    end
  end

  private

  def entry_pdf
    entry = Entry.find(params[:entry_id])
    if(params[:company].present?)
      entry.set_company params[:company]
    end
    entry.set_invoice_number
    entry.set_invoice_date
    EntryPdf.new(entry)
  end

  def send_invoice_pdf
    send_file entry_pdf.to_pdf,
              filename: entry_pdf.filename,
              type: "application/pdf",
              disposition: "inline"
  end

  def party_invoice_pdf
    party_invoice = PartyInvoice.find(params[:id])
    party_invoice.set_invoice_date
    PartyInvoicePdf.new(party_invoice)
  end

  def send_party_invoice_pdf
    send_file party_invoice_pdf.to_pdf,
              filename: party_invoice_pdf.filename,
              type: "application/pdf",
              disposition: "inline"
  end

  def render_sample_html
    render template: "entries/pdf", layout: "bill_pdf", locals: { entry: @entry}
  end

  def render_sample_party_invoice_html
    render template: "party_invoices/pdf", layout: "bill_pdf", locals: { party_invoice: @party_invoice}
  end
end
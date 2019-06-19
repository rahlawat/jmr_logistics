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

  def ledger_show
    respond_to do |format|
      format.pdf { send_ledger_pdf }
      if Rails.env.development?
        format.html { render_sample_ledger_html }
      end
    end
  end

  def invoice_statement_show
    respond_to do |format|
      format.pdf { send_invoice_statement_pdf }
      if Rails.env.development?
        format.html { render_sample_invoice_statement_html }
      end
    end
  end

  def expenses_show
    respond_to do |format|
      format.pdf { send_expenses_pdf }
      if Rails.env.development?
        format.html { render_sample_expenses_html }
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
    party_invoice.set_invoice_date params[:party_invoice][:date]
    PartyInvoicePdf.new(party_invoice)
  end

  def invoice_statement_pdf
    from_date = params[:invoice_statement][:from_date]
    to_date = params[:invoice_statement][:to_date]
    party_invoices = PartyInvoice.where(:invoice_generated => true, :date => from_date..to_date).order(date: :asc)
    InvoiceStatementPdf.new(party_invoices, from_date, to_date)
  end

  def expenses_pdf
    from_date = params[:expense_statement][:from_date]
    to_date = params[:expense_statement][:to_date]
    entries = Entry.where( :date => from_date..to_date).order(invoice_number: :asc)
    ExpenseStatementPdf.new(entries, from_date, to_date)
  end

  def ledger_pdf
    from_date = params[:ledger][:from_date]
    to_date = params[:ledger][:to_date]
    party_code = params[:ledger][:party_code]
    party_invoices = PartyInvoice.where(:party_code => party_code, :date => from_date..to_date, :invoice_generated => true).order(date: :asc)
    payment_receipts = PaymentReceipt.where(:party_code => party_code, :date => from_date..to_date).order(date: :asc)
    party = Party.where(:party_code => party_code).first
    opening_balance = party.opening_balances.select { |opening_balance|
      (Time.now.month < 4 && opening_balance.year == Time.now.year - 1 )|| (Time.now.month >= 4 && opening_balance.year == Time.now.year)
    }
    @balance = opening_balance[0].balance
    LedgerPdf.new(party_invoices, payment_receipts, from_date, to_date, party_code)
  end

  def send_party_invoice_pdf
    send_file party_invoice_pdf.to_pdf,
              filename: party_invoice_pdf.filename,
              type: "application/pdf",
              disposition: "inline"
  end

  def send_invoice_statement_pdf
    send_file invoice_statement_pdf.to_pdf,
              filename: invoice_statement_pdf.filename,
              type: "application/pdf",
              disposition: "inline"
  end

  def send_expenses_pdf
    send_file expenses_pdf.to_pdf,
              filename: expenses_pdf.filename,
              type: "application/pdf",
              disposition: "inline"
  end

  def send_ledger_pdf
    send_file ledger_pdf.to_pdf,
              filename: ledger_pdf.filename,
              type: "application/pdf",
              disposition: "inline"
  end


  def render_sample_html
    render template: "entries/pdf", layout: "bill_pdf", locals: { entry: @entry}
  end

  def render_sample_party_invoice_html
    render template: "party_invoices/pdf", layout: "bill_pdf", locals: { party_invoice: @party_invoice}
  end

  def render_sample_invoice_statement_html
    from_date = params[:invoice_statement][:from_date]
    to_date = params[:invoice_statement][:to_date]
    render template: "party_invoices/invoice_statement_pdf", layout: "bill_pdf", locals: {
        party_invoices: PartyInvoice.where(:invoice_generated => true, :date => from_date..to_date).order(:invoice_number)}
  end

  def render_sample_expenses_html
    render template: "entries/expenses_pdf", layout: "bill_pdf", locals: { entries: Entry.all}
  end

  def render_sample_ledger_html
    render template: "parties/ledger_pdf", layout: "bill_pdf", locals: { entries: Entry.all}
  end
end
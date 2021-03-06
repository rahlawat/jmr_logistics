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
        format.html { render_sample_party_invoice_html }
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


  def balance_for_parties
    respond_to do |format|
      format.pdf { send_balance_for_parties_pdf }
      if Rails.env.development?
        format.html { render_sample_balance_html }
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
    party_invoices = PartyInvoice.where(:invoice_generated => true, :date => from_date..to_date).order(invoice_number: :asc)
    InvoiceStatementPdf.new(party_invoices, from_date, to_date)
  end

  def balance_for_parties_pdf
    from_date = params[:parties_balance][:from_date]
    to_date = params[:parties_balance][:to_date]
    BalanceForPartiesPdf.new(from_date, to_date)
  end

  def expenses_pdf
    from_date = params[:expense_statement][:from_date]
    to_date = params[:expense_statement][:to_date]
    entries = Entry.where( :invoice_date => from_date..to_date).order(invoice_number: :asc)
    ExpenseStatementPdf.new(entries, from_date, to_date)
  end

  def ledger_pdf
    from_date = params[:ledger][:from_date]
    to_date = params[:ledger][:to_date]
    party_code = params[:ledger][:party_code]
    party_invoices = PartyInvoice.where(:party_code => party_code, :date => from_date..to_date, :invoice_generated => true).order(date: :asc)
    payment_receipts = PaymentReceipt.where(:party_code => party_code, :date => from_date..to_date).order(date: :asc)
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

  def send_balance_for_parties_pdf
    send_file balance_for_parties_pdf.to_pdf,
              filename: balance_for_parties_pdf.filename,
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
    entry = Entry.find(params[:entry_id])
    if(params[:company].present?)
      entry.set_company params[:company]
    end
    entry.set_invoice_number
    entry.set_invoice_date
    truck_details = TruckDetails.find_by_truck_number(entry.truck_number)
    render template: "entries/pdf", layout: "bill_pdf", locals: { entry: entry, truck_details: truck_details}
  end

  def render_sample_party_invoice_html
    party_invoice = PartyInvoice.find(params[:id])
    party_invoice.set_invoice_date params[:party_invoice][:date]
    render template: "party_invoices/pdf", layout: "bill_pdf", locals: { party_invoice: party_invoice}
  end

  def render_sample_invoice_statement_html
    from_date = params[:invoice_statement][:from_date]
    to_date = params[:invoice_statement][:to_date]
    party_invoices = PartyInvoice.where(:invoice_generated => true, :date => from_date..to_date).order(invoice_number: :asc)
    render template: "party_invoices/invoice_statement_pdf", layout: "bill_pdf", locals: {party_invoices: party_invoices}
  end

  def render_sample_expenses_html
    from_date = params[:expense_statement][:from_date]
    to_date = params[:expense_statement][:to_date]
    entries = Entry.where( :invoice_date => from_date..to_date).order(invoice_number: :asc)
    render template: "entries/expense_statement_pdf", layout: "bill_pdf", locals: { entries: entries}
  end

  def render_sample_ledger_html
    from_date = params[:ledger][:from_date]
    to_date = params[:ledger][:to_date]
    party_code = params[:ledger][:party_code]
    party_invoices = PartyInvoice.where(:party_code => party_code, :date => from_date..to_date, :invoice_generated => true).order(date: :asc)
    payment_receipts = PaymentReceipt.where(:party_code => party_code, :date => from_date..to_date).order(date: :asc)
    all_payments = party_invoices + payment_receipts
    sorted_payments = all_payments.sort_by {|x| x.date}
    party = Party.where(:party_code => party_code).first
    opening_balance = party.calculate_balance_till_date from_date
    balance = opening_balance
    render template: "parties/ledger_pdf", layout: "bill_pdf", locals: { payments: sorted_payments, balance: balance, party: party }
  end

  def render_sample_balance_html
    from_date = params[:parties_balance][:from_date]
    to_date = params[:parties_balance][:to_date]
    parties = Party.order(:party_code)
    render template: "parties/balance_for_parties_pdf", layout: "bill_pdf", locals: { parties: parties, from_date: from_date, to_date: to_date }
  end
end
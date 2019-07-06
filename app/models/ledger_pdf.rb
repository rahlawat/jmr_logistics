require "render_anywhere"
class LedgerPdf
  include RenderAnywhere

  def initialize(party_invoices,payment_receipts, from_date, to_date, party_code)
    @party_invoices = party_invoices
    @payment_receipts = payment_receipts
    all_payments = @party_invoices + @payment_receipts
    @sorted_payments = all_payments.sort_by {|x| x.date}
    @from_date = from_date
    @to_date = to_date
    party = Party.where(:party_code => party_code).first
    opening_balance = party.calculate_current_balance from_date
    @balance = opening_balance
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.stylesheets << 'app/assets/stylesheets/application.scss'
    kit.to_file("#{Rails.root}/public/ledger.pdf")
  end

  def filename
    "Ledger_#{@from_date}_#{@to_date}.pdf"
  end

  private

  attr_reader :party_invoices, :payment_receipts, :sorted_payments

  def as_html
    render template: "parties/ledger_pdf", layout: "bill_pdf", locals: { payments: @sorted_payments, balance: @balance }
  end
end
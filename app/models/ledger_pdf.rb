require "render_anywhere"
class LedgerPdf
  include RenderAnywhere

  def initialize(entries,payment_receipts, from_date, to_date)
    @entries = entries
    @payment_receipts = payment_receipts
    @from_date = from_date
    @to_date = to_date
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.stylesheets << 'app/assets/stylesheets/application.scss'
    kit.to_file("#{Rails.root}/public/expense_statement.pdf")
  end

  def filename
    "Ledger_#{@from_date}_#{@to_date}.pdf"
  end

  private

  attr_reader :entries, :payment_receipts

  def as_html
    render template: "entries/expense_statement_pdf", layout: "bill_pdf", locals: { entries: @entries }
  end
end
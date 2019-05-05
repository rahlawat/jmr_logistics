require "render_anywhere"
class InvoiceStatementPdf
  include RenderAnywhere

  def initialize(entries, from_date, to_date)
    @entries = entries
    @from_date = from_date
    @to_date = to_date
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.stylesheets << 'app/assets/stylesheets/application.scss'
    kit.to_file("#{Rails.root}/public/invoice_statement.pdf")
  end

  def filename
    "Invoice_Statement_#{@from_date}_#{@to_date}.pdf"
  end

  private

  attr_reader :entries

  def as_html
    render template: "entries/expense_statement_pdf", layout: "bill_pdf", locals: { entries: @entries }
  end
end
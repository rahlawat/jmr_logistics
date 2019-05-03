require "render_anywhere"
class InvoiceStatementPdf
  include RenderAnywhere

  def initialize(party_invoices)
    @party_invoices = party_invoices
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.stylesheets << 'app/assets/stylesheets/application.scss'
    kit.to_file("#{Rails.root}/public/invoice_statement.pdf")
  end

  def filename
    "Invoice_Statement_#{@party_invoices.count}.pdf"
  end

  private

  attr_reader :party_invoices

  def as_html
    render template: "party_invoices/invoice_statement_pdf", layout: "bill_pdf", locals: { party_invoices: @party_invoices }
  end
end
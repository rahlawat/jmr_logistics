require "render_anywhere"
class InvoiceStatementPdf
  include RenderAnywhere

  def initialize(party_invoices, from_date, to_date)
    @party_invoices = party_invoices
    @from_date = from_date
    @to_date = to_date
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.stylesheets << '/Users/renuahla/jmr_logistics/app/assets/stylesheets/application.scss'
    kit.to_file("#{Rails.root}/public/invoice_statement.pdf")
  end

  def filename
    "Invoice_Statement_#{@from_date}_#{@to_date}.pdf"
  end

  private

  attr_reader :party_invoices

  def as_html
    ActionController::Base.new.render_to_string(template: "party_invoices/invoice_statement_pdf", layout: "bill_pdf", locals: { party_invoices: @party_invoices })
  end
end
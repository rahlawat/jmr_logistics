require "render_anywhere"
class PartyInvoicePdf
  include RenderAnywhere

  def initialize(party_invoice)
    @party_invoice = party_invoice
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.stylesheets << 'app/assets/stylesheets/application.scss'
    kit.to_file("#{Rails.root}/public/party_invoice.pdf")
  end

  def filename
    "Party_Invoice_#{@party_invoice.invoice_number}.pdf"
  end

  private

  attr_reader :party_invoice

  def as_html
    render template: "party_invoices/pdf", layout: "bill_pdf", locals: { party_invoice: @party_invoice }
  end
end
require "render_anywhere"
class PartyInvoicePdf
  include RenderAnywhere

  def initialize(party_invoice)
    @party_invoice = party_invoice
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3', footer_html: "#{Rails.root}/app/views/party_invoices/footer.html",
                     'margin-bottom': '2.75in')
    kit.stylesheets << 'app/assets/stylesheets/application.scss'
    kit.stylesheets << 'app/assets/stylesheets/party_invoices.scss'
    kit.to_file("#{Rails.root}/public/party_invoice.pdf")
  end

  def filename
    "Party_Invoice_#{@party_invoice.invoice_number}.pdf"
  end

  private

  attr_reader :party_invoice

  def as_html
    ActionController::Base.new.render_to_string("party_invoices/pdf", layout: "bill_pdf", locals: { party_invoice: @party_invoice })
  end
end
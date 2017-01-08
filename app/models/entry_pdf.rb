require "render_anywhere"

class EntryPdf
  include RenderAnywhere

  def initialize(entry)
    @entry = entry
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.stylesheets << 'app/assets/stylesheets/application.scss'
    kit.to_file("#{Rails.root}/public/invoice.pdf")
  end

  def filename
    "Invoice_#{@entry.id}.pdf"
  end

  private

  attr_reader :entry

  def as_html
    render template: "entries/pdf", layout: "bill_pdf", locals: { entry: @entry }
  end
end
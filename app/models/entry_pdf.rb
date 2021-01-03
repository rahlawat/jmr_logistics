require "render_anywhere"
class EntryPdf
  include RenderAnywhere

  def initialize(entry)
    @entry = entry
    @truck_details = TruckDetails.find_by_truck_number(@entry.truck_number)
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    Dir['/tmp/build_*/public/packs/css/application-*.css'].first()
    kit.stylesheets << Dir['/tmp/build_*/public/packs/css/application-*.css'].first()
    kit.to_file("#{Rails.root}/public/invoice.pdf")
  end

  def filename
    "Invoice_#{@entry.id}.pdf"
  end

  private

  attr_reader :entry, :truck_details

  def as_html
    ActionController::Base.new.render_to_string(template: "entries/pdf", layout: "bill_pdf", locals: { entry: @entry, truck_details: @truck_details })
  end
end
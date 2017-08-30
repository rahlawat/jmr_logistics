class DownloadsController < ApplicationController

  def show
    respond_to do |format|
      format.pdf { send_invoice_pdf }
      if Rails.env.development?
        format.html { render_sample_html }
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

  def render_sample_html
    render template: "entries/pdf", layout: "bill_pdf", locals: { entry: @entry}
  end
end
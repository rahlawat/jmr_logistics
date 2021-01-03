require "pry"
require "render_anywhere"
class BalanceForPartiesPdf
  include RenderAnywhere

  def initialize(from_date, to_date)
    @from_date = from_date
    @to_date = to_date
    @parties = Party.order(:party_code)
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/pdf.scss"
    kit.to_file("#{Rails.root}/public/balance_for_parties_statement.pdf")
  end

  def filename
    "balance_for_parties_statement_till_#{@from_date}_#{@to_date}.pdf"
  end

  private

  attr_reader :parties, :from_date, :to_date

  def as_html
    ActionController::Base.new.render_to_string(template: "parties/balance_for_parties_pdf", layout: "bill_pdf", locals: { parties: @parties, from_date: @from_date, to_date: @to_date  })
  end
end
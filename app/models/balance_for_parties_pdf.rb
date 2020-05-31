require "pry"
require "render_anywhere"
class BalanceForPartiesPdf
  include RenderAnywhere

  def initialize(to_date)
    @to_date = to_date.strftime
    # @parties = Party.order(:party_code)
    @parties = [Party.first]
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A3')
    kit.stylesheets << 'app/assets/stylesheets/application.scss'
    kit.to_file("#{Rails.root}/public/balance_for_parties_statement.pdf")
  end

  def filename
    "balance_for_parties_statement_till_#{@to_date}.pdf"
  end

  private

  attr_reader :parties, :to_date

  def as_html
    render template: "parties/balance_for_parties_pdf", layout: "bill_pdf", locals: { parties: @parties, to_date: @to_date  }
  end
end
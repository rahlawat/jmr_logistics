class Party < ApplicationRecord
  validates :party_name, presence: true,
            length: { maximum: 40 }, uniqueness: true
  validates :party_code, presence: true,
            length: { maximum: 15 }, uniqueness: true
  validates :gst_in, presence: true,
            length: { maximum: 15 }, uniqueness: true
  validates :address, presence: true,
            length: { maximum: 80 }

  has_many :payment_receipts
  has_many :opening_balances


  def calculate_current_balance from_date, to_date
    from_date = DateTime.parse(from_date)
    to_date = DateTime.parse(to_date)
    opening_balance = self.opening_balances.select { |opening_balance|
      (from_date.month < 4 && opening_balance.year == from_date.year - 1 )|| (from_date.month >= 4 && opening_balance.year == from_date.year)
    }
    if !opening_balance.any?
      return 0
    end
    balance = opening_balance[0].balance
    from_date_for_data = DateTime.new(opening_balance[0].year, 4, 1)
    payments = PaymentReceipt.where(:party_code => party_code, :date => from_date_for_data..to_date).order(date: :asc)
    party_invoices = PartyInvoice.where(:party_code => party_code, :date => from_date_for_data..to_date, :invoice_generated => true).order(date: :asc)
    payments.each do |payment|
      balance = balance - payment.amount
    end

    party_invoices.each do |party_invoice|
      balance = balance + (party_invoice.freight_total - (party_invoice.freight_total * party_invoice.bills[0].tds_percentage/100))
    end
    balance
  end
end



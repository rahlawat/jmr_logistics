class PartyInvoice < ApplicationRecord
  validates :party_code, presence: true, length: { maximum: 15 }
  validates :invoice_number, presence: true, numericality: true
  has_many :bills

  def party_name
    Party.find_by_party_code(party_code).party_name
  end

  def party
    Party.find_by_party_code(party_code)
  end

  def set_invoice_date
    if self.invoice_date.nil?
      self.invoice_date = Date.today
      self.invoice_generated = true
      save
    end
  end

  def invoice_total
    total = 0
    self.bills.each do |bill|
      total += bill.balance
    end
    total
  end
end
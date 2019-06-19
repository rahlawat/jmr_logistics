class PartyInvoice < ApplicationRecord
  validates :party_code, presence: true, length: { maximum: 15 }
  validates :invoice_number, presence: true, uniqueness: true, length: { maximum: 15 }
  has_many :bills

  def party_name
    Party.find_by_party_code(party_code).party_name
  end

  def party
    Party.find_by_party_code(party_code)
  end

  def get_all_gr_numbers
    gr_number =""
    self.bills.each do |bill|
      gr_number += bill.entry.payment_summary.g_r_number + ','
    end
    gr_number
  end

  def set_invoice_date invoice_date
    self.date = invoice_date
    self.invoice_generated = true
    save
  end

  def invoice_amount
    amount = 0
    self.bills.each do |bill|
      amount += bill.balance
    end
    amount
  end

  def cancel_invoice reason_for_cancellation, revised_invoice
    self.reason_for_cancellation = reason_for_cancellation
    self.invoice_cancelled = true
    self.revised_invoice_id = revised_invoice.id
    save
  end

  def invoice_total
    total = 0
    self.bills.each do |bill|
      total += bill.balance
    end
    total
  end
end
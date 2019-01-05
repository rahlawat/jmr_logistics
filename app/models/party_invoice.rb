class PartyInvoice < ApplicationRecord
  validates :party_code, presence: true, length: { maximum: 15 }
  validates :invoice_number, presence: true, numericality: true
  has_many :bills

  def party_name
    Party.find_by_party_code(party_code).party_name

  end
end
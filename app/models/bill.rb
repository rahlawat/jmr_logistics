class Bill < ApplicationRecord
  validates :weight2, presence: true, numericality: true
  validates :kanta2, presence: true, numericality: true
  validates :tds_percentage, presence: true, numericality: true
  validates :bill_number, length: { maximum: 15 }
  belongs_to :entry
  belongs_to :party_invoice

  def freight
    ((weight2 * entry.rate2) + kanta2).to_i
  end

  def balance
    freight - entry.party_advance_2
  end
end
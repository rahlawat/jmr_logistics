class PaymentSummary < ApplicationRecord
  belongs_to :entry
  validates :g_r_number, presence: true,
            length: { maximum: 15 }
  validates :weight, presence: true, numericality: true
  validates :kanta, presence: true, numericality: true
  validates :shortage1, presence: true,
            length: { maximum: 25 }
  validates :shortage2, presence: true, numericality: true
  validates :payment_charges, presence: true, numericality: true
end

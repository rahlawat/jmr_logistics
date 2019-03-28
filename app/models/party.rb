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
end
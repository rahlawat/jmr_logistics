class BillEntry < ApplicationRecord
  validates :bill_no, presence: true
  validates :payment_received_at, presence: true
  validates :tds_percentage, presence: true, numericality: true
  belongs_to :entry, dependent: :destroy
end

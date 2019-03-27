class PaymentReceipt < ApplicationRecord
  validates :amount, presence: true, numericality: true, length: { maximum: 7 }

  enum mode_of_payment: { imps: 'IMPS/UPI', cash: 'Cash', neft: 'NEFT/RTGS', cheque: 'Cheque' }
  belongs_to :party
end
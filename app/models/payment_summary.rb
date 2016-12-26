class PaymentSummary < ApplicationRecord
  belongs_to :entry, dependent: :destroy
end

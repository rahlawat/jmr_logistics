class Entry < ApplicationRecord
  has_one :payment_summary, dependent: :destroy
end

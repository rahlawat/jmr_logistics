class OpeningBalance < ApplicationRecord
  validates :year, presence: true, numericality: true,
            length: { is: 4 }
  validates :balance, presence: true, numericality: true,
            length: { maximum: 15 }

  belongs_to :party
end
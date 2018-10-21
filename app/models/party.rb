class Party < ApplicationRecord
  validates :party_name, presence: true,
            length: { maximum: 25 }, uniqueness: true
  validates :party_code, presence: true,
            length: { maximum: 15 }, uniqueness: true
end
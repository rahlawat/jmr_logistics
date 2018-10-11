class TruckDetails < ApplicationRecord
  validates :truck_number, presence: true,
            length: { maximum: 15 }, uniqueness: true
  validates :truck_owner, presence: true,
            length: { maximum: 25 }
end
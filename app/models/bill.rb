class Bill < ApplicationRecord
  validates :weight2, presence: true, numericality: true
  validates :kanta2, presence: true, numericality: true
  validates :tds_percentage, presence: true, numericality: true
  belongs_to :entry, dependent: :destroy

  def freight
    ((weight2 * entry.rate2) + kanta2).to_i
  end

  def balance
    freight - entry.party_advance_2
  end

  def set_bill_number
    if self.bill_number.nil?
      bills = Bill.all
      if bills.maximum(:bill_number).nil?
        self.bill_number = 1
      else
        self.bill_number = bills.maximum(:bill_number) + 1
      end
    end

  end
end
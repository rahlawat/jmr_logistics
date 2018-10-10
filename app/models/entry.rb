class Entry < ApplicationRecord
  validates :truck_number, presence: true,
            length: { maximum: 15 }
  validates :station, presence: true,
            length: { maximum: 15 }
  validates :firm, presence: true,
            length: { maximum: 15}
  validates :truck_owner, presence: true,
            length: { maximum: 15 }
  validates :rate1, presence: true, numericality: true
  validates :rate2, presence: true, numericality: true
  validates :self_advance_1, presence: true, numericality: true
  validates :party_advance_2, presence: true, numericality: true
  validates :commission, presence: true, numericality: true
  has_one :payment_summary, dependent: :destroy
  has_one :bill_entry, dependent: :destroy

  # , format: {with: ''}

  def freight2
    ((payment_summary.weight * rate2) + payment_summary.kanta).to_i
  end

  def freight1
    ((payment_summary.weight * rate1) + payment_summary.kanta).to_i
  end

  def cash_to_driver
    (freight1 * 4) / 100
  end

  def paid_to_truck_owner
    freight1 - self_advance_1 - cash_to_driver - commission - payment_summary.shortage2 - payment_summary.payment_charges
  end

  def tds
    if(bill_entry)
      (freight2 * bill_entry.tds_percentage) / 100
    end
  end

  def bill_payment
    if(bill_entry)
      freight2 - party_advance_2 - payment_summary.shortage2 - tds
    end
  end

  def loss_or_profit
    if(bill_entry)
      bill_payment - freight2
    end
  end

  def self.search(truck_number, date)
    if truck_number and !date.present?
      where('truck_number LIKE ?', "%#{truck_number}%")
    elsif truck_number and date
      where('truck_number LIKE ? and entry_date = ?', "%#{truck_number}%", date.to_date)
    else
      all
    end
  end

  def set_invoice_number
    if self.invoice_number.nil?
      entries = Entry.where(company: self.company)
      if entries.maximum(:invoice_number).nil?
        self.invoice_number = 1
      else
        self.invoice_number = entries.maximum(:invoice_number) + 1
      end
      save
    end

  end

  def set_invoice_date
    if self.invoice_date.nil?
        self.invoice_date = Date.today
      save
    end
  end

  def set_company(company)
    if self.company.nil?
      self.company = company
      save
    end
  end

  def self.entries_without_gr_entry_between(start_date, end_date)
    entries_witout_gr_entry = Array.new
    entries = where(entry_date: start_date.to_date..end_date.to_date)
    entries.each do |entry|
      entries_witout_gr_entry.push(entry) if !entry.payment_summary.present?
    end
    entries_witout_gr_entry
  end

  def self.entries_without_bill_entry_between(start_date, end_date)
    entries_without_bill_entry = Array.new
    entries = where(entry_date: start_date.to_date..end_date.to_date)
    entries.each do |entry|
      entries_without_bill_entry.push(entry) if !entry.bill_entry.present?
    end
    entries_without_bill_entry
  end

  def self.entries_with_invoice_number(invoice_number)
    if invoice_number
      where(invoice_number: invoice_number)
    end
  end

end

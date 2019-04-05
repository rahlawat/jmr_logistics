class ChangeBillNumberFromIntegerToStringInBills < ActiveRecord::Migration[5.0]
  def change
    change_column :bills, :bill_number, :string
  end
end

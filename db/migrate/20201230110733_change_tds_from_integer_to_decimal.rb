class ChangeTdsFromIntegerToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :bills, :tds_percentage, :decimal, precision: 5, scale: 2
  end
end

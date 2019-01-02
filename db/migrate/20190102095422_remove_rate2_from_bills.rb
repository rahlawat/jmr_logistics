class RemoveRate2FromBills < ActiveRecord::Migration[5.0]
  def change
    remove_column :bills, :rate2
  end
end

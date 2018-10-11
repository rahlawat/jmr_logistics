class AlterColumnTruckNumberForTruckDetail < ActiveRecord::Migration[5.0]
  def change
    add_index :truck_details, :truck_number, unique: true
  end
end

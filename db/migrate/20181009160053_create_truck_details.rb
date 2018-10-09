class CreateTruckDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :truck_details do |t|
      t.string :truck_owner
      t.string :truck_number
    end
  end
end

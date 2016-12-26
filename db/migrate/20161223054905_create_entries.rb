class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.string :truck_number
      t.date :date
      t.string :station
      t.string :truck_owner
      t.string :firm
      t.decimal :advance
      t.decimal :rate1
      t.decimal :rate2
      t.timestamps
      t.timestamps
    end
  end
end

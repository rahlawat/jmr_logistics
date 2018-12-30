class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.integer :bill_number
      t.decimal :weight2
      t.decimal :kanta2
      t.decimal :rate2
      t.integer :tds_percentage
      t.string :party_code
      t.references :entry, foreign_key: true
      t.timestamps
    end
  end
end

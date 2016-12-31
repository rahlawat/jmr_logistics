class CreateBillEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :bill_entries do |t|
      t.string :bill_no
      t.date :payment_received_at
      t.integer :tds_percentage
      t.references :entry, foreign_key: true
      t.timestamps
    end
  end
end

class DropBillEntries < ActiveRecord::Migration[5.0]
  def change
    drop_table :bill_entries
  end
end

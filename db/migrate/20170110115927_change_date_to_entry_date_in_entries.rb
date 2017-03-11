class ChangeDateToEntryDateInEntries < ActiveRecord::Migration[5.0]
  def change
    rename_column :entries, :date, :entry_date
  end
end

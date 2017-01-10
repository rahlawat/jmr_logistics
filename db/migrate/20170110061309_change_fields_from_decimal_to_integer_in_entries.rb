class ChangeFieldsFromDecimalToIntegerInEntries < ActiveRecord::Migration[5.0]
  def change
    change_column :entries, :self_advance_1, :integer
    change_column :entries, :party_advance_2, :integer
    change_column :entries, :rate1, :integer
    change_column :entries, :rate2, :integer
    change_column :entries, :commission, :integer
  end
end

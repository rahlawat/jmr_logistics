class AddAdvanceSelfToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :self_advance_1, :decimal
    add_column :entries, :party_advance_2, :decimal
    remove_column :entries, :advance, :decimal
  end
end

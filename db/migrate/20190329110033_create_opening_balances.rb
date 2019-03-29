class CreateOpeningBalances < ActiveRecord::Migration[5.0]
  def change
    create_table :opening_balances do |t|
      t.integer :year
      t.integer :balance
    end
  end
end

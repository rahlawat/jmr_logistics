class AddPartyToOpeningBalances < ActiveRecord::Migration[5.0]
  def change
    add_reference :opening_balances, :party, foreign_key: true
  end
end

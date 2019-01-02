class RemovePartyCodeFromBills < ActiveRecord::Migration[5.0]
  def change
    remove_column :bills, :party_code
  end
end

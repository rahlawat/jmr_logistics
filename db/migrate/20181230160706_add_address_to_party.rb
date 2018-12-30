class AddAddressToParty < ActiveRecord::Migration[5.0]
  def change
    add_column :parties, :address, :string
  end
end

class AddPartyCodeToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :party_code, :string
  end
end

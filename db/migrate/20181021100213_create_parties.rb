class CreateParties < ActiveRecord::Migration[5.0]
  def change
    create_table :parties do |t|
      t.string :party_name
      t.string :party_code
    end

    add_index :parties, [:party_name, :party_code],  unique: true
  end
end

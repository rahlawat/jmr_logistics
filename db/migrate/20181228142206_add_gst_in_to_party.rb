class AddGstInToParty < ActiveRecord::Migration[5.0]
  def change
    add_column :parties, :gst_in, :string
  end
end

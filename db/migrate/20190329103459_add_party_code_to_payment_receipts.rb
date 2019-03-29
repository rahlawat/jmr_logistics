class AddPartyCodeToPaymentReceipts < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_receipts, :party_code, :string
  end
end

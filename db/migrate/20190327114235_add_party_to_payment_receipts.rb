class AddPartyToPaymentReceipts < ActiveRecord::Migration[5.0]
  def change
    add_reference :payment_receipts, :party, foreign_key: true
  end
end

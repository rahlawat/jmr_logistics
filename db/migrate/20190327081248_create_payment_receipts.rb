class CreatePaymentReceipts < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_receipts do |t|
      t.string :mode_of_payment
      t.date :date
      t.integer :amount
      t.integer :cheque_number
      t.timestamps
    end
  end
end

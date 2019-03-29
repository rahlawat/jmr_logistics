class AddRemarkToPaymentReceipts < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_receipts, :remark, :string
  end
end

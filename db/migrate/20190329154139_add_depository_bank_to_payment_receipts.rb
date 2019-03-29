class AddDepositoryBankToPaymentReceipts < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_receipts, :depository_bank, :string
  end
end

class RemoveSheetNumberFromPaymentSummaries < ActiveRecord::Migration[5.0]
  def change
    remove_column :payment_summaries, :sheet_number
  end
end

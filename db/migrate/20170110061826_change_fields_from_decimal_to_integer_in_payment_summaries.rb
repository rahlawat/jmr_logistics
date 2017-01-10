class ChangeFieldsFromDecimalToIntegerInPaymentSummaries < ActiveRecord::Migration[5.0]
  def change
    change_column :payment_summaries, :kanta, :integer
    change_column :payment_summaries, :shortage2, :integer
    change_column :payment_summaries, :payment_charges, :integer
  end
end

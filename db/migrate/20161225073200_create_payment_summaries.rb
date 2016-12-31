class CreatePaymentSummaries < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_summaries do |t|
      t.string :g_r_number
      t.decimal :weight
      t.decimal :kanta
      t.decimal :shortage1
      t.decimal :shortage2
      t.decimal :payment_charges
      t.string :sheet_number
      t.references :entry, foreign_key: true
      t.timestamps
    end
  end
end

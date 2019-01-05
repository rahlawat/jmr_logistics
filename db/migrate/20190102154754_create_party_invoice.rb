class CreatePartyInvoice < ActiveRecord::Migration[5.0]
  def change
    create_table :party_invoices do |t|
      t.string :party_code
      t.integer :invoice_number
      t.date :invoice_date
      t.boolean :invoice_generated
      t.timestamps
    end
  end
end

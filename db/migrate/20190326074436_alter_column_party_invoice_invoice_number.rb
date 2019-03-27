class AlterColumnPartyInvoiceInvoiceNumber < ActiveRecord::Migration[5.0]
  def change
    add_index :party_invoices, :invoice_number, unique: true
  end
end

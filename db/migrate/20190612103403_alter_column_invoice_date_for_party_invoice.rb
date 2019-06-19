class AlterColumnInvoiceDateForPartyInvoice < ActiveRecord::Migration[5.0]
  def change
    rename_column :party_invoices, :invoice_date, :date
  end
end

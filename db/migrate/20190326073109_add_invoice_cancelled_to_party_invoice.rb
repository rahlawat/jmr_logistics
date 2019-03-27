class AddInvoiceCancelledToPartyInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :party_invoices, :invoice_cancelled, :boolean, default: false
  end
end

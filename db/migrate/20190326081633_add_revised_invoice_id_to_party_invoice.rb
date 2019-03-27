class AddRevisedInvoiceIdToPartyInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :party_invoices, :revised_invoice_id, :integer
  end
end

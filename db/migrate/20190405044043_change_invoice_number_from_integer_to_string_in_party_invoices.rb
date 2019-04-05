class ChangeInvoiceNumberFromIntegerToStringInPartyInvoices < ActiveRecord::Migration[5.0]
  def change
    change_column :party_invoices, :invoice_number, :string
  end
end

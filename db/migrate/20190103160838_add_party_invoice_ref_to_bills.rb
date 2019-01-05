class AddPartyInvoiceRefToBills < ActiveRecord::Migration[5.0]
  def change
    add_reference :bills, :party_invoice, foreign_key: true
  end
end

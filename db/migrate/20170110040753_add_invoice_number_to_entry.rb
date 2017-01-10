class AddInvoiceNumberToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :invoice_number, :integer
  end
end

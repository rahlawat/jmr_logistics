class AddInvoiceDateToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :invoice_date, :date
  end
end

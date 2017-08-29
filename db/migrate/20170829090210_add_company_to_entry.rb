class AddCompanyToEntry < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :company, :string
  end
end

class ChangeShortage1InPaymentSummary < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :payment_summaries do |t|
        dir.up   { t.change :shortage1, :string }
        dir.down { t.change :shortage1, :integer }
      end
    end
  end
end

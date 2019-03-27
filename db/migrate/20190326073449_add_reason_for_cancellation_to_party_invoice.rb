class AddReasonForCancellationToPartyInvoice < ActiveRecord::Migration[5.0]
  def change
    add_column :party_invoices, :reason_for_cancellation, :string
  end
end

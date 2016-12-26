class PaymentSummariesController < ApplicationController
  def create
    @entry = Entry.find(params[:entry_id])
    @payment_summary = @entry.build_payment_summary(payment_summary_params)
    @payment_summary.save
    redirect_to entry_path(@entry)
  end

  private
  def payment_summary_params
    params.require(:payment_summary).permit!
  end
end

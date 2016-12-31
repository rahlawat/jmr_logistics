class PaymentSummariesController < ApplicationController
  def create
    @entry = Entry.find(params[:entry_id])
    @payment_summary = @entry.build_payment_summary(payment_summary_params)
    if @payment_summary.save
      redirect_to entry_path(@entry)
    else
      render 'new'
    end
  end

  def update
    @entry = Entry.find(params[:entry_id])
    @payment_summary = PaymentSummary.find(params[:id])
    if @payment_summary.update(payment_summary_params)
      redirect_to @entry
    else
      render 'edit'
    end
  end

  def edit
    @entry = Entry.find(params[:entry_id])
    @payment_summary = PaymentSummary.find(params[:id])
  end

  def new
    @entry = Entry.find(params[:entry_id])
    @payment_summary = PaymentSummary.new
  end

  private
  def payment_summary_params
    params[:payment_summary].delete :rate1
    params[:payment_summary].delete :freight1
    params.require(:payment_summary).permit(:g_r_number, :weight, :kanta, :shortage1, :shortage2, :payment_charges, :sheet_number)
  end
end

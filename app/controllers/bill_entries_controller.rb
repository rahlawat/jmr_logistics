class BillEntriesController < ApplicationController
  def create
    @entry = Entry.find(params[:entry_id])
    @bill_entry = @entry.build_bill_entry(bill_entry_params)
    if @bill_entry.save
      redirect_to @entry
    else
      render 'new'
    end
  end

  def update
    @entry = Entry.find(params[:entry_id])
    @bill_entry = BillEntry.find(params[:id])
    if @bill_entry.update(bill_entry_params)
      redirect_to @entry
    else
      render 'edit'
    end
  end

  def edit
    @entry = Entry.find(params[:entry_id])
    @bill_entry = BillEntry.find(params[:id])
  end

  def new
    @entry = Entry.find(params[:entry_id])
    @bill_entry = BillEntry.new
  end

  private
  def bill_entry_params
    params[:bill_entry].delete :bill_payment
    params.require(:bill_entry).permit(:bill_no, :payment_received_at, :tds_percentage)
  end
end

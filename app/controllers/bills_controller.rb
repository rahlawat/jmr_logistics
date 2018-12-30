class BillsController < ApplicationController
  def new
    @entry = Entry.find(params[:entry_id])
    @bill = Bill.new
  end

  def create
    @entry = Entry.find(params[:entry_id])
    @bill = @entry.build_bill(bill_params)
    if @bill.save
      redirect_to entry_path(@entry)
    else
      render 'new'
    end
  end

  def edit
    @entry = Entry.find(params[:entry_id])
    @bill = Bill.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:entry_id])
    @bill = Bill.find(params[:id])
    if @bill.update(bill_params)
      redirect_to entry_path(@entry)
    else
      render 'edit'
    end
  end

  private
  def bill_params
    params.require(:bill).permit(:weight2, :kanta2, :rate2, :tds_percentage, :party_code)
  end
end

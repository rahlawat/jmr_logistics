class TruckDetailsController < ApplicationController

  def index
    @truck_detail = TruckDetails.all
  end

  def new
    @truck_detail = TruckDetails.new
  end

  def show
    @truck_detail = TruckDetails.find(params[:id])
  end

  def create
    @truck_detail = TruckDetails.new(truck_detail_params)

    @truck_detail.save
    if @truck_detail.save
      redirect_to @truck_detail
    else
      render 'new'
    end
  end

  private
  def truck_detail_params
    params.require(:truck_detail).permit!
  end
end

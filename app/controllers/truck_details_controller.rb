class TruckDetailsController < ApplicationController

  def index
    @truck_details = TruckDetails.all.page params[:page]
  end

  def new
    @truck_detail = TruckDetails.new
  end

  def show
    @truck_detail = TruckDetails.find(params[:id])
  end

  def create
    @truck_detail = TruckDetails.new(truck_detail_params)

    if @truck_detail.save
      redirect_to @truck_detail
    else
      render 'new'
    end
  end

  def edit
    @truck_detail = TruckDetails.find(params[:id])
  end

  def update
    @truck_detail = TruckDetails.find(params[:id])

    if @truck_detail.update(truck_detail_params)
      redirect_to @truck_detail
    else
      render 'edit'
    end
  end

  def destroy
    @truck_detail = TruckDetails.find(params[:id])
    @truck_detail.destroy

    redirect_to truck_details_path
  end

  private
  def truck_detail_params
    params.require(:truck_detail).permit!
  end
end

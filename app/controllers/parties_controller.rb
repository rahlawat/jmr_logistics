class PartiesController < ApplicationController
  before_action :authenticate_user!
  def index
    @parties = Party.order(:party_code).page params[:page]
  end

  def new
    @party = Party.new
  end

  def show
    @party = Party.find(params[:id])
  end

  def create
    @party = Party.new(party_params)

    if @party.save
      redirect_to @party
    else
      render 'new'
    end
  end

  def edit
    @party = Party.find(params[:id])
  end

  def update
    @party = Party.find(params[:id])

    if @party.update(party_params)
      redirect_to @party
    else
      render 'edit'
    end
  end

  def destroy
    @party = Party.find(params[:id])
    @party.destroy

    redirect_to parties_path
  end

  def party_by_code
    @party = Party.find_by_party_code(params[:party_code])
    render json: @party
  end

  private
  def party_params
    params.require(:party).permit!
  end
end

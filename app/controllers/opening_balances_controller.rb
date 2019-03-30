class OpeningBalancesController < ApplicationController
  before_action :authenticate_user!
  def index
    @opening_balances = OpeningBalance.all.page params[:page]
  end

  def new
    @party = Party.find(params[:party_id])
    @opening_balance = OpeningBalance.new
  end

  def show
    @opening_balance = OpeningBalance.find(params[:id])
  end

  def create
    @party = Party.find(params[:party_id])
    @opening_balance = OpeningBalance.new(opening_balance_params)
    opening_balance_for_year = @party.opening_balances.find_by_year(opening_balance_params[:year])
    if opening_balance_for_year.nil?
      @opening_balance.party = @party
      if @opening_balance.save
        redirect_to @party
      else
        render 'new'
      end
    else
      flash.now[:error] = "Opening balance for this year for this party already exists."
      render 'new'
    end
  end

  def edit
    @party = Party.find(params[:party_id])
    @opening_balance = OpeningBalance.find(params[:id])
  end

  def update
    @party = Party.find(params[:party_id])
    opening_balance_for_year = @party.opening_balances.find_by_year(opening_balance_params[:year])
    @opening_balance = OpeningBalance.find(params[:id])
    if (opening_balance_for_year.nil? || @opening_balance.id == opening_balance_for_year.id)

      if @opening_balance.update(opening_balance_params)
        redirect_to @party
      else
        render 'edit'
      end
    else
      flash.now[:error] = "Opening balance for this year for this party already exists."
      render 'edit'
    end
  end

  def destroy
    @opening_balance = OpeningBalance.find(params[:id])
    @opening_balance.destroy

    redirect_to parties_path
  end

  private
  def opening_balance_params
    params.require(:opening_balance).permit!
  end
end

class EntriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @entries = Entry.search(params[:truck_number], params[:date])
  end

  def new
    @entry = Entry.new
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])

    if @entry.update(entry_params)
      redirect_to @entry
    else
      render 'edit'
    end
  end

  def create
    @entry = Entry.new(entry_params)

    @entry.save
    if @entry.save
      redirect_to @entry
    else
      render 'new'
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    redirect_to entries_path
  end

  private
  def entry_params
    params.require(:entry).permit!
  end
end

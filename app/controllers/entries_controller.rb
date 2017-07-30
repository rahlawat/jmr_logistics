class EntriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @entries = Entry.all.page params[:page]
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

  def search
    if(params[:truck_number])
      @entries = Entry.search(params[:truck_number], params[:entry_date])
    elsif(params[:start_date] and params[:end_date])
      @entries = Entry.entries_without_gr_entry_between(params[:start_date], params[:end_date])
    elsif(params[:entry_start_date] and params[:entry_end_date])
      @entries = Entry.entries_without_bill_entry_between(params[:entry_start_date], params[:entry_end_date])
    elsif(params[:invoice_number])
      @entries = Entry.entries_with_invoice_number(params[:invoice_number])
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

require 'pry'
class BillsController < ApplicationController
  def new
    @entry = Entry.find(params[:entry_id])
    @bill = Bill.new
  end

  def create
    @entry = Entry.find(params[:entry_id])
    @bill = @entry.build_bill(bill_params)
    @party_invoice = PartyInvoice.find_by_invoice_number(bill_params[:bill_number])
    if(@party_invoice.nil?)
      @bill.create_party_invoice(party_code: @entry.party_code, invoice_number: bill_params[:bill_number])
    elsif(!@party_invoice.nil? && @party_invoice.party_code != @entry.party_code)
      flash.now[:error] = "Cannot add Entry to invoice of another Party"
      render 'new' and return
    elsif(!@party_invoice.nil? && @party_invoice.invoice_generated)
      flash.now[:error] = "This invoice has already been sent. Create a new invoice."
      render 'new' and return
    elsif(!@party_invoice.nil?)
      @bill.party_invoice = @party_invoice
    end
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
    params.require(:bill).permit(:weight2, :kanta2, :rate2, :tds_percentage, :party_code, :bill_number)
  end
end

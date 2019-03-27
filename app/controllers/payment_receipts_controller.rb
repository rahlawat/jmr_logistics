class PaymentReceiptsController < ApplicationController
  def index
    @payment_receipts = PaymentReceipt.all.page params[:page]
  end

  def new
    @payment_receipt = PaymentReceipt.new
  end

  def show
    @payment_receipt = PaymentReceipt.find(params[:id])
  end

  def create
    @payment_receipt = PaymentReceipt.new(payment_receipt_params)
    @party = Party.find_by_party_code(payment_receipt_params[:party_code])
    @payment_receipt.party = @party
    if @payment_receipt.save
      redirect_to @payment_receipt
    else
      render 'new'
    end
  end

  def edit
    @payment_receipt = PaymentReceipt.find(params[:id])
  end

  def update
    @payment_receipt = PaymentReceipt.find(params[:id])
    @party = Party.find_by_party_code(payment_receipt_params[:party_code])
    @payment_receipt.party = @party
    if @payment_receipt.update(payment_receipt_params)
      redirect_to @payment_receipt
    else
      render 'edit'
    end
  end

  def destroy
    @payment_receipt = PaymentReceipt.find(params[:id])
    @payment_receipt.destroy

    redirect_to payment_receipts_path
  end

  private
  def payment_receipt_params
    params.require(:payment_receipt).permit!
  end
end

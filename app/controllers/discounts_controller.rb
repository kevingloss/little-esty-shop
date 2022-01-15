class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    # require 'pry'; binding.pry
    merchant = Merchant.find(params[:merchant_id])
    @discount = merchant.discounts.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.discounts.create(discount_params)

    redirect_to model: merchant
  end

  def destroy
    # require 'pry'; binding.pry
  end

  private
  def discount_params
    params.require(:discount).permit(:merchant_id, :percent, :threshold)
  end
end

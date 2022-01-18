class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    merchant = Merchant.find(params[:merchant_id])
    @discount = merchant.discounts.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.discounts.new(discount_params)

    if discount.save
      redirect_to model: merchant
    else
      flash[:error] = discount.errors.full_messages
      redirect_to new_merchant_discount_path(merchant)
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
    if discount.update(discount_params)
      redirect_to model: [discount.merchant, discount]
    else
      flash[:error] = discount.errors.full_messages
      redirect_to edit_merchant_discount_path(discount.merchant, discount)
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    Discount.destroy(params[:id])

    redirect_to merchant_discounts_path(merchant)
  end

  private
  def discount_params
    params.require(:discount).permit(:merchant_id, :percent, :threshold)
  end
end

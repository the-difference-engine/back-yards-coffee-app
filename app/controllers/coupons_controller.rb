class CouponsController < ApplicationController
  before_action :authenticate_employee!

  def new
  end

  def create
    coupon = StripeTool.create_coupon(
      params[:id],
      params[:percent_off],
      params[:duration],
      params[:amount_off],
      params[:duration_in_months],
      params[:max_redemptions],
      params[:redeem_by]
      )
    if coupon.save
      redirect_to '/employees/dashboard'
    else
      redirect_to '/coupons/new'
    end
  end

  def edit

  end

  def update

  end

  def delete
  end
end

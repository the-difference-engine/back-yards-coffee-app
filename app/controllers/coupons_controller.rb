class CouponsController < ApplicationController
  before_action :authenticate_employee!

  def new
  end

  def create
    coupon = StripeTool.create_coupon(
      params[:id],
      params[:amount_and_percent],
      params[:amount],
      params[:duration],
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

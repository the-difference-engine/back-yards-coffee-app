class CouponsController < ApplicationController
  before_action :authenticate_employee!

  def new
  end

  def create
    coupon = Stripe::Coupon.create(coupon_params)
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

  private

  def coupon_params
    params.permit(
      :id,
      :percent_off,
      :duration
    )
  end
end

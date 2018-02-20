class CouponsController < ApplicationController

  def new
    @coupons = 
  end

  def create
    coupon = Stripe::Coupon.create(
      :amount_off =>,
      :percent_off => 25,
      :duration => 'repeating',
      :duration_in_months => 3,
      :id => ''
    )

  end

  def edit

  end

  def update

  end

  def delete
  end

end

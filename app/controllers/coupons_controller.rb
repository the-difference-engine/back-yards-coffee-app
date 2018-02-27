class CouponsController < ApplicationController
  before_action :authenticate_employee!

  def new
  end

  def create
    coupon = Stripe::Coupon.create(
      :id => params['id'],
      # :amount_off => params['amount_off'] || null,
      :percent_off => params['percent_off'],
      :duration => params['duration']
      # :duration_in_months => params['duration_in_months'] || '',
      # :max_redemptions => params['max_redemptions'] || '',
      # :redeem_by => params['redeem_by'] || ''
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

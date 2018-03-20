class Api::CouponsController < ApplicationController

  def index
    @coupon = Stripe::Coupon.retrieve(params[:data])

    if @coupon
      render :json => @coupon
    else
      render :json => 'Coupon does not exist'
    end
  end
end

class CouponsController < ApplicationController
  before_action :authenticate_employee!

  def new
  end

  def create
  end

  def edit

  end

  def update

  end

  def delete
  end

  private

  def coupon_params
    params.require(:employee).permit(
      :id,
      :duration,
      :amount_off,
      :currency,
      :duration_in_months,
      :max_redemptions,
      :percent_off,
      :redeem_by
    )
  end
end

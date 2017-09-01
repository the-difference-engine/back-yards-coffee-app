class Api::CartedSubscriptionsController < ApplicationController
  def update
    @carted_subscription = CartedSubscription.find_by(id: params[:id])
    @carted_subscription.quantity = params[:qnty]
    if @carted_subscription.save
      render :json => @carted_subscription
    else
      puts "THERE IS AN ERROR_______#{@carted_subscription.errors.full_messages}"
      render :json => { error: @carted_subscription.errors.full_messages }
    end
  end

  def destroy
    @carted_subscription = CartedSubscription.find_by(id: params[:id])
    @carted_subscription.destroy
    render :json => @carted_subscription
  end
end

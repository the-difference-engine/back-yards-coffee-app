class SubscriptionsController < ApplicationController
  def new
    @customer = current_customer
    @carted_subscriptions = @customer.carted_subscriptions
  end
end

class SubscriptionsController < ApplicationController
  before_action :authenticate_customer!
  def new
    if current_customer
      @customer = current_customer
      @carted_subscriptions = CartedSubscription.my_carted(@customer.id)
    else
      flash['warning'] = 'You must be have an account to create a subscription.'
      redirect_to new_customer_registration_path
    end
  end
end

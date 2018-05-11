class DailySubscriptionJob < ApplicationJob
  queue_as :default

  def perform
    @subscriptions = CartedSubscription.where(
      next_order_date: Time.zone.today,
      status: 'active'
    )
    @subscriptions.each do |subscription|
      OrderJob.perform_later(subscription, subscription.customer)
    end
  end
end

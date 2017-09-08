class AddIntervalCountToCartedSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :carted_subscriptions, :interval_count, :integer
  end
end

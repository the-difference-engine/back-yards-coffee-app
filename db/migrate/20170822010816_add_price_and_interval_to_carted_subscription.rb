class AddPriceAndIntervalToCartedSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :carted_subscriptions, :amount, :integer
    add_column :carted_subscriptions, :interval, :string
  end
end

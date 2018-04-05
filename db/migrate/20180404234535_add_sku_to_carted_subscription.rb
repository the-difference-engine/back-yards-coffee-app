class AddSkuToCartedSubscription < ActiveRecord::Migration[5.0]
  def change
    add_column :carted_subscriptions, :sku, :string
  end
end

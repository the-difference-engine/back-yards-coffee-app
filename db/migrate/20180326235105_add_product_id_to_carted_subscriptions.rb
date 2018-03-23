class AddProductIdToCartedSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :carted_subscriptions, :product_id, :string
  end
end

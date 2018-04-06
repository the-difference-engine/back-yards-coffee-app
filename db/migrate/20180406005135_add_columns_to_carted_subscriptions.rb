class AddColumnsToCartedSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :carted_subscriptions, :products, :jsonb, null: false, default: '{}'
    add_column :carted_subscriptions, :plan, :string
    add_column :carted_subscriptions, :expired_at, :date
    add_column :carted_subscriptions, :order_created_at, :date
    add_index :carted_subscriptions, :products, using: :gin
  end
end

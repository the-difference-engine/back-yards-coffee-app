class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :stripe_order_id
      t.integer :customer_id

      t.timestamps
    end
  end
end

class CreateCartedSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :carted_subscriptions do |t|
      t.integer :quantity
      t.string :plan_id
      t.string :status
      t.bigint :customer_id
      t.string :grind

      t.timestamps
    end
  end
end

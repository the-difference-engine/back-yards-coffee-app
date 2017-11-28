class AddPlanNameToCartedSubscriptions < ActiveRecord::Migration[5.0]
  def change
    add_column :carted_subscriptions, :plan_name, :string
  end
end

class RemoveGrindFromCartedSubscriptions < ActiveRecord::Migration[5.0]
  def change
    remove_column :carted_subscriptions, :grind
  end
end

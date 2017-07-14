class ChangeUserIdToCustomerId < ActiveRecord::Migration[5.0]
  def change
    rename_column :carted_products, :user_id, :customer_id
  end
end

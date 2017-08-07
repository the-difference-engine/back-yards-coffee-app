class IncreaseIntergerSizeForCustomerIdInCartedProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :carted_products, :customer_id, :integer, limit: 8
  end
end

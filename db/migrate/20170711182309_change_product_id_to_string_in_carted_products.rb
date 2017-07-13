class ChangeProductIdToStringInCartedProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :carted_products, :product_id, :string
    add_column :carted_products, :sku, :string
  end
end

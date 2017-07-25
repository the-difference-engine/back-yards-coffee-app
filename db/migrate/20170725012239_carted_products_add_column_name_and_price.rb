class CartedProductsAddColumnNameAndPrice < ActiveRecord::Migration[5.0]
  def change
    add_column :carted_products, :name, :string
    add_column :carted_products, :price, :integer
  end
end

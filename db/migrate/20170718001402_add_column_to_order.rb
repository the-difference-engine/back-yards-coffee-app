class AddColumnToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :customer_id, :integer
    add_column :orders, :price, :integer
    add_column :orders, :total_price, :integer
  end
end

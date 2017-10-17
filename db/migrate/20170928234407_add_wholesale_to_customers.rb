class AddWholesaleToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :wholesaler, :boolean
  end
end

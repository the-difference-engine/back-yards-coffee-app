class AddAttributesToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :address, :string
    add_column :customers, :city, :string
    add_column :customers, :state, :string
    add_column :customers, :zip_code, :integer
  end
end

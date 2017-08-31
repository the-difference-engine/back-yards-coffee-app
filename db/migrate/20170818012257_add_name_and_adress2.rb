class AddNameAndAdress2 < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :first_name, :string
    add_column :customers, :last_name, :string
    add_column :customers, :Address2, :string
  end
end

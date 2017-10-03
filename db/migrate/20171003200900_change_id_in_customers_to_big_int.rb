class ChangeIdInCustomersToBigInt < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :id, :bigint, null: false, unique: true
  end
end

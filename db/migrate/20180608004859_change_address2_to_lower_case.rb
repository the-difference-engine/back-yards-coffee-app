class ChangeAddress2ToLowerCase < ActiveRecord::Migration[5.0]
  def change
    rename_column :customers, :address2, :address2
  end
end

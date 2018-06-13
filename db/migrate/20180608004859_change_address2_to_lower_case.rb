class ChangeAddress2ToLowerCase < ActiveRecord::Migration[5.0]
  def change
    rename_column :customers, :Address2, :address2
  end
end

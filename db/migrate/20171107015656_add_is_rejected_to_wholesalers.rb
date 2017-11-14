class AddIsRejectedToWholesalers < ActiveRecord::Migration[5.0]
  def change
   add_column :wholesalers, :is_rejected, :boolean, default: false 
  end
end

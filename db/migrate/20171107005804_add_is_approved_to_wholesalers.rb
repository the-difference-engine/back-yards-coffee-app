class AddIsApprovedToWholesalers < ActiveRecord::Migration[5.0]
  def change
    add_column :wholesalers, :is_approved, :boolean, default: false
  end
end

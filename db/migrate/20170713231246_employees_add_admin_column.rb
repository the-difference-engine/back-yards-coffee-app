class EmployeesAddAdminColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :admin, :boolean
  end
end

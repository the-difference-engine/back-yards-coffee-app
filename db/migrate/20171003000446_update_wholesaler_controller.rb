class UpdateWholesalerController < ActiveRecord::Migration[5.0]
  def change
    add_column :wholesalers, :billing_address, :string
    add_column :wholesalers, :billing_city, :string
    add_column :wholesalers, :billing_state, :string
    add_column :wholesalers, :billing_zip_code, :string
    add_column :wholesalers, :shipping_address, :string
    add_column :wholesalers, :shipping_city, :string
    add_column :wholesalers, :shipping_state, :string
    add_column :wholesalers, :shipping_zip_code, :string
    add_column :wholesalers, :website, :string
    add_column :wholesalers, :accounts_payable_contact_name, :string
    add_column :wholesalers, :accounts_payable_contact_email, :string
    add_column :wholesalers, :accounts_payable_contact_phone, :string
    add_column :wholesalers, :retailer, :boolean
    add_column :wholesalers, :tax_exempt, :boolean
    add_column :wholesalers, :delivery_instructions, :string
    add_column :wholesalers, :recieving_hours, :string
    add_column :wholesalers, :days_closed, :string
  end
end

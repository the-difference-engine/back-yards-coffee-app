class AddStripeCustomerIdToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :stripe_customer_id, :string
  end
end

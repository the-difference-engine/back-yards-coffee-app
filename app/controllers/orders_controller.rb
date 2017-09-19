class OrdersController < ApplicationController
 
  def show
    carted_products = CartedProduct.my_carted(guest_or_customer_id)
    items = carted_products.map{ |o| {type: 'sku', parent: o.sku, quantity: o.quantity } }

    if customer_signed_in?
      @customer = current_customer
    elsif Customer.find_by(email: guest_or_customer_id.to_s + '@email.com')
      @customer = Customer.find_by(email: guest_or_customer_id.to_s + '@email.com')
    else
      email = guest_or_customer_id.to_s + '@email.com'
      @customer = Customer.new(email: email)
      @customer.assign_customer_id
      @customer.save(validate: false)
    end

    first_name = @customer.first_name || 'Back of the Yards'
    line1 = @customer.address || '2059 W. 47th St'
    city = @customer.city || 'Chicago'
    postal_code = @customer.zip_code || '60609'


    @order = Stripe::Order.create(
      :currency => 'usd',
      :customer => @customer.stripe_customer_id,
      :items => items,
      :shipping => {
        :name => first_name,
        :address => {
          :line1 => line1,
          :city => city,
          :country => 'US',
          :postal_code => postal_code
        }
      },
    )

    # p order.pay(:source => params[:stripeToken])
  end

end
# <h1>Order Overview</h1>

# <% @order.items.each do |item| %>
#   <h3>Type: <%= item.type%></h3>
#   <p>Description: <%= item.description%></p>
#   <p>Amount: <%= item.amount %></p>
# <% end %>
# <% @order.shipping_methods.each do |shipping_method| %>
#   <p>Description: <%= shipping_method.description%></p>
#   <p>Amount: <%= shipping_method.amount %></p>
#   <p>Estimated Arrival Date: <%= shipping_method.delivery_estimate.date%></p>
# <% end %>

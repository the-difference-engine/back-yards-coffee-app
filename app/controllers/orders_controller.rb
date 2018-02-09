class OrdersController < ApplicationController
  def new
    params_order_id = params[:order_id]
    @stripe_order = Stripe::Order.retrieve(params_order_id)
    # This could be how to get the description
    #  i.e USPS Priority Mail Express
    @shipping = @stripe_order.items.select{ |item| item.type == 'shipping' }

    # This is a list of all the shipping options
    @shipping_methods = @stripe_order.shipping_methods.select { |shipping| shipping.currency == 'usd' }

    # copied from charges
    email = current_customer ? current_customer.email : customer_email(order.customer)
    token = params[:stripeToken]

    begin
      order.pay(source: token, email: email)
    rescue Stripe::CardError => e
      flash[:error] = e.message
      return redirect_to "/orders/new?order_id=#{order_id}"
    end

    # CREATE ORDER OBJECT
    confirmed_order = Order.create(stripe_order_id: @stripe_order.id, customer_id: guest_or_customer_id)

    carted_products = CartedProduct.my_carted(guest_or_customer_id)
    carted_products.map do |carted_product|
      carted_product.status = 'product ordered'
      carted_product.order_id = confirmed_order.id
      carted_product.save
    end
    flash[:success] = 'Charge created!'
    redirect_to "/orders/#{confirmed_order.id}"
    # end copied from charges 
    redirect_to '/orders/show'
  end
  def create
    if customer_signed_in?
      customer = current_customer
      customer.update(customer_params)
      p @order = StripeTool.create_order(current_customer)
      order_id = @order[:order]["id"]
      # else
      # TODO: GUEST ORDER
      redirect_to "/orders/new?order_id=#{order_id}"
    end
    # TODO: REDIRECT TO 'ORDERS NEW
  end

  def show
    # @order = Order.find(params[:id])
    # @stripe_order = Stripe::Order.retrieve(@order.stripe_order_id)
    # @address = @stripe_order.shipping.address.line1
    # @address2 = "#{@stripe_order.shipping.address.city}, #{@stripe_order.shipping.address.state} #{@stripe_order.shipping.address.postal_code}"

    render "receipt.html.erb"
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :address, :Address2, :city, :state, :zip_code)
  end
end

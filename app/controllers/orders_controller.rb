class OrdersController < ApplicationController
  def new
    @stripe_order = Stripe::Order.retrieve(params[:order_id]) if params[:order_id].present?

    @stripe_order_quantity = @stripe_order&.items&.select{|item| item.type == "sku"}&.map{|item| item.quantity}&.sum || 0
    @total_quantity = @stripe_order_quantity

    @sku_items = @stripe_order.items.select{|item| item.type == "sku"}
    puts @sku_items
    @stripe_order_total = @stripe_order&.items&.select{|item| item.type == "sku"}&.map{|item| item.amount * 0.01}&.sum || 0
    @shipping = @stripe_order&.items&.select { |item| item.type == 'shipping' }&.map{|item| item.amount * 0.01}&.sum || 0
    @tax = @stripe_order&.items&.select { |item| item.type == 'tax' }&.map{|item| item.amount * 0.01}&.sum || 0

    @total = @stripe_order_total + @shipping + @tax
    # This could be how to get the description
    #  i.e USPS Priority Mail Express
  end

  def create
    redirect_to '/orders/new' unless customer_signed_in?
    customer = current_customer
    customer.update(customer_params)

    if customer.carted_items.present?
      begin
        @order = StripeTool.create_order(current_customer)
        order_id = @order[:order]['id']
      rescue => e
        flash[:error] = e.message
        return redirect_to '/cart'
      end
    end

    # TODO: GUEST ORDER
    redirect_to "/orders/new?order_id=#{order_id}"
    # TODO: REDIRECT TO 'ORDERS NEW
  end

  def show
    @order = Order.find(params[:id])
    @stripe_order = Stripe::Order.retrieve(@order.stripe_order_id)
    @address = @stripe_order.shipping.address.line1
    @address2 = "#{@stripe_order.shipping.address.city}, #{@stripe_order.shipping.address.state} #{@stripe_order.shipping.address.postal_code}"
  end

  def update
    # TODO: GUEST ORDER
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :address, :Address2, :city, :state, :zip_code)
  end
end

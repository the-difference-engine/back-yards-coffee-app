class CartedProductsController < ApplicationController
  def create
    carted_product = CartedProduct.find_by(status: 'carted',
                                            customer_id: guest_or_customer_id,
                                            sku: params[:sku])
    if carted_product
      carted_product.quantity = carted_product.quantity.to_i + params[:quantity].to_i
    else
      carted_product = CartedProduct.new(quantity: params[:quantity],
                                          product_id: params[:product_id],
                                          sku: params[:sku],
                                          customer_id: guest_or_customer_id,
                                          status: 'carted',
                                          price: params[:price].to_i,
                                          name: params[:name])
    end

    if carted_product.save
      flash[:success] = 'Product Added to Cart!'
      redirect_to '/cart'
    else
      flash[:error] = carted_product.errors.full_messages.join(', ').gsub(/[']/,"\\\\\'")
      redirect_to "/products/#{params[:product_id]}"
    end
  end

  def index
    @carted_products = CartedProduct.my_carted(guest_or_customer_id)
    @carted_subscriptions = CartedSubscription.my_carted(guest_or_customer_id)
    @products_total = @carted_products.sum{|s| s.price * s.quantity}
    # @subscriptions_total = @carted_subscriptions.sum{|s| s.price * s.quantity}
    @cart_total = @products_total
    if @carted_products.empty? && @carted_subscriptions.empty?
      flash[:warning] = 'Your cart is currently empty.'
      redirect_to '/'
    end
  end

end

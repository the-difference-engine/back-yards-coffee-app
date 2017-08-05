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
    total = 0
    @carted_products.each do |cp|
      total += cp.stripe_attributes
    end
    @cart_total = total
    if @carted_products.empty?
      flash[:warning] = 'Your cart is currently empty.'
      redirect_to '/'
    end
  end

end

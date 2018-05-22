class CartedProductsController < ApplicationController
  def create
    carted_product = CartedProduct.find_by(
      status: 'carted',
      customer_id: guest_or_customer_id,
      sku: params[:sku]
    )
    if carted_product
      carted_product.quantity = carted_product.quantity.to_i + params[:quantity].to_i
      if carted_product.save
        flash[:success] = "Product quantity increased by #{params[:quantity]}"
        redirect_to '/cart'
      end
    else
      @product = StripeCache.new.product(params[:product_id])
      price = @product.skus.data.find { |sku| sku.mrchid == params[:sku] } .price
      carted_product = CartedProduct.new(
        quantity: params[:quantity],
        product_id: params[:product_id],
        sku: params[:sku],
        customer_id: guest_or_customer_id,
        status: 'carted',
        price: price,
        name: @product.name
      ) ### supposed to catch and up the quantity if its the same ###
      if carted_product.save
        flash[:success] = 'Product Added to Cart!'
        redirect_to '/products'
      else
        flash[:error] = carted_product.errors.values.join(', ').gsub(/[']/, "\\\\\'")
        redirect_to "/products/#{params[:product_id]}"
      end
    end
  end

  def index
    @customer = current_customer || Customer.new
    @carted_products = CartedProduct.my_carted(guest_or_customer_id)
    @products_total = @carted_products.sum { |s| s.price * s.quantity }
    @cart_total = @products_total

    gon.push(
      :cartedProducts => @carted_products,
    )

    if @carted_products.empty?
      flash[:warning] = 'Your cart is currently empty.'
      redirect_to '/'
    end
  end
end

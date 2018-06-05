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
      price = @product.skus.data.find { |sku| sku.id == params[:sku] } .price
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
    @carted_products = @customer.carted_products.where(status: 'carted')
    @carted_subscriptions = @customer.current_subscription.status == 'pending' ? @customer.current_subscription.products['items'] : []
    @products_total = @carted_products.sum { |s| s.price * s.quantity }
    gon.push(
      cartedProducts: @carted_products,
      cartedSubscriptions: @carted_subscriptions
    )
    stripe_products = Stripe::Product.list(limit: 100).data
    @carted_subscriptions.map! do |item|
      sku = item['parent']
      product_id = Stripe::SKU.retrieve(sku).product
      product_name = stripe_products.find { |p| p.id == product_id } .name
      item.merge({ 'description' => product_name })
    end
    @carted_subscriptions
    @customer.current_subscription.products
    if @carted_products.empty? && @carted_subscriptions.empty?
      flash[:warning] = 'Your cart is currently empty.'
      redirect_to '/'
    end
  end
end

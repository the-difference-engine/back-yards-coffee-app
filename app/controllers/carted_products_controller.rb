class CartedProductsController < ApplicationController
  def create
    if current_customer
      if CartedProduct.find_by(status: 'carted', customer_id: current_customer.id, sku: params[:sku])
        carted_product = CartedProduct.find_by(status: 'carted', customer_id: current_customer.id, product_id: params[:product_id])
        carted_product.quantity = carted_product.quantity.to_i + params[:quantity].to_i
        if carted_product.save
          flash[:success] = %Q[successfully updated quantity of existing product in <a href="/cart">cart</a>!]
          redirect_to "/products"
        else
          flash[:danger] = "Quantity can't be less than 1."
          redirect_to "/products/#{params[:product_id]}"
        end
      else
        product = Stripe::Product.retrieve(id: params[:product_id])
        product_price = product.skus.data.select{|obj| obj.id == params[:sku]}[0].price
        @carted_product = CartedProduct.new(quantity: params[:quantity],
                                            product_id: params[:product_id],
                                            sku: params[:sku],
                                            customer_id: guest_or_customer_id,
                                            status: 'carted',
                                            price: product_price,
                                            name: product.name)
        if @carted_product.save
          flash[:success] = 'Order Created!'
          redirect_to '/cart'
        else
          flash[:error] = @carted_product.errors.full_messages.join(', ').gsub(/[']/,"\\\\\'")
          redirect_to "/products/#{params[:product_id]}"
        end
      end
    else
      flash[:danger] = %Q[You must <a href="/customers/sign_up">sign up</a>/<a href="/customers/sign_in">sign in</a> to add items to your cart.]
      redirect_to "/customers/sign_in"
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

class CartedProductsController < ApplicationController
  def create 
    @carted_product = CartedProduct.new(quantity: params[:quantity],
                                        product_id: params[:product_id],
                                        sku: params[:sku],
                                        customer_id: guest_or_customer_id,
                                        status: 'carted')
    if @carted_product.save
      flash[:success] = 'Order Created!'
      redirect_to '/cart'
    else
      flash[:error] = @carted_product.errors.full_messages.join(', ').gsub(/[']/,"\\\\\'")
      redirect_to "/products/#{params[:product_id]}"
    end
  end 

  def index 
    @carted_products = CartedProduct.my_carted(guest_or_customer_id)
    if @carted_products.empty?
      flash[:warning] = 'Your cart is currently empty.'
      redirect_to '/'
    end
  end 

  def destroy 
    carted_product = CartedProduct.find_by(id: params[:id])
    carted_product.status = "removed"
    carted_product.save
    flash[:success] = "Successfully removed"
    redirect_to "/cart"
  end 

end

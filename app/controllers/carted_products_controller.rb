class CartedProductsController < ApplicationController
  def create
    customer_id = customer_signed_in? ? current_customer.id : session['session_id'] 
    @carted_product = CartedProduct.new(quantity: params[:quantity].to_i,
                                        product_id: params[:product_id],
                                        sku: params[:sku],
                                        user_id: customer_id,
                                        status: 'carted')
    if @carted_product.save
      flash[:success] = 'Order Created!'
      redirect_to '/cart'
    else
      flash[:warning] = @carted_product.errors.full_messages
      redirect_to "/products/#{params[:product_id]}"
    end
  end 

  def index
    customer_id = customer_signed_in? ? current_customer.id : session['session_id'] 
    @carted_products = CartedProduct.where(status: 'carted', user_id: customer_id)
    if @carted_products.empty?
      flash[:warning] = 'You have nothing in your cart.'
      redirect_to '/'
    end
    @carted_products.each{ |c| c.stripe_attributes }
  end 

  def destroy 
    carted_product = CartedProduct.find_by(id: params[:id])
    carted_product.status = "removed"
    carted_product.save
    flash[:success] = "Successfully removed"
    redirect_to "/cart"
  end 

end


class Api::CartedProductsController < ApplicationController
  def update
    @carted_product = CartedProduct.find_by(id: params[:id])
    @carted_product.update(
      quantity: params[:qnty]
    )
    render :json => @carted_product
  end

  def destroy
    @carted_product = CartedProduct.find_by(id: params[:id])
    @carted_product.destroy
    render :json => @carted_product  
  end

end

class Api::CartedProductsController < ApplicationController
  def update
    @carted_product = CartedProduct.find_by(id: params[:id])
    @carted_product.quantity = params[:qnty]
    if @carted_product.save
      render :json => @carted_product
    else
      render :json => { error: @carted_product.errors.full_messages }
    end
  end

  def destroy
    @carted_product = CartedProduct.find_by(id: params[:id])
    @carted_product.destroy
    render :json => @carted_product
  end

end

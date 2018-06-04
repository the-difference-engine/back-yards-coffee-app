class Api::CartedProductsController < ApplicationController
  before_action :load_carted_product
  def update
    @carted_product.update(carted_product_params)
    if @carted_product.save
      render json: @carted_product
    else
      render json: { error: @carted_product.errors.full_messages }
    end
  end

  def destroy
    @carted_product.destroy
    render json: @carted_product
  end

  private

  def load_carted_product
    @carted_product = CartedProduct.find(params[:id])
  end

  def carted_product_params
    params.permit(:quantity)
  end

end

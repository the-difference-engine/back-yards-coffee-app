class MenusController < ApplicationController
  before_action :authenticate_employee!

  def new
    @categories = Category.all
    @menu_item = Product.new
  end

  def create
    @menu_item = Product.create(menu_item_params)
    redirect_to '/coffee_house'
  end

  def edit
    menu_id = params[:id]
    @menu_item = Product.find(menu_id)
    @categories = Category.all
  end

  def update
    menu_id = params[:id]
    @menu_item = Product.find(menu_id)
    @menu_item.update(menu_item_params)
    redirect_to '/coffee_house'
  end

  def destroy
    menu_id = params[:id]
    @menu_item = Product.find(menu_id)
    @menu_item.destroy
    redirect_to '/coffee_house'
  end

  private

  def menu_item_params
    params.permit(
      :name,
      :description,
      :price,
      :category_id
    )
  end
end

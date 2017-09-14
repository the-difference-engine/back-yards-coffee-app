class MenusController < ApplicationController
  before_action :authenticate_employee!
  
  def new
    @categories=Category.all
    @menu_item = Product.new
  end

  def create
    @menu_item = Product.create(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      category_id: params[:category_id]
    )
    redirect_to '/coffee_house'
  end

  def edit
    menu_id = params[:id]
    @menu_item = Product.find_by(id: menu_id)
    @categories= Category.all
  end

  def update
    menu_id = params[:id]
    @menu_item = Product.find_by(id: menu_id)
    @menu_item.update(name: params[:name],
                      description: params[:description],
                      price: params[:price],
                      category_id: params[:category_id])
    redirect_to '/coffee_house'
  end

  def destroy
    menu_id = params[:id]
    @menu_item = Product.find_by(id: menu_id)
    @menu_item.destroy
    redirect_to '/coffee_house'
  end
end

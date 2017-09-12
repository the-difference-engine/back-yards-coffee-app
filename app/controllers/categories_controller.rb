class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.create(
      name: params[:name]
      )
    redirect_to '/coffee_house'
  end

  def show
    category_id = params[:id]
    @category = Category.find_by(id: category_id)
  end

  def edit
    category_id = params[:id]
    @category = Category.find_by(id: category_id)
  end

  def update
    category_id = params[:id]
    @category = Category.find_by(id: category_id)
    @category.update(name: params[:name])
    redirect_to '/coffee_house'
  end

  def destroy
    category_id = params[:id]
    @category = Category.find_by(id: category_id)
    @category.destroy
    redirect_to '/coffee_house'
  end
end

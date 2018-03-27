class CategoriesController < ApplicationController
  before_action :authenticate_employee!

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save
      redirect_to '/coffee_house'
    else
      redirect_to '/categories/new'
    end
  end

  def edit
    category_id = params[:id]
    @category = Category.find(category_id)
  end

  def update
    category_id = params[:id]
    @category = Category.find(category_id)
    @category.update(name: params[:name])
    redirect_to '/coffee_house'
  end

  def destroy
    category_id = params[:id]
    @category = Category.find(category_id)
    @category.destroy
    redirect_to '/coffee_house'
  end

  private

  def category_params
    params.permit(
      :name
    )
  end
end

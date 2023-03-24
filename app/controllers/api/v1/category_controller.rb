class Api::V1::CategoryController < ApplicationController
  before_action :set_category, only: [:update]

  def create
    Category.create!(category_params)
  end

  def update
    @category.update!(category_params)
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end

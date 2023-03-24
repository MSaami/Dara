class Api::V1::CategoryController < ApplicationController
  def create
    Category.create!(category_params)
  end

  def update
    Category.update!(category_params)
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end

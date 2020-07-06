# frozen_string_literal: true

class CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)

    if @category.save
      render json: { category: @category.as_json, message: 'Created category' }, status: :created
    else
      render json: { data: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.permit(:title)
  end
end

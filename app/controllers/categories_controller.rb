class CategoriesController < ApplicationController
    def create 
        @category = Category.new(category_params)
        
        if @category.save
            render json: { message: 'Created category' }, status: :created   
        else
            render json: { message: 'Category not created', data: @category.errors }, status: :unprocessable_entity
        end
    end

    private

    def category_params
        params.permit(:title)
    end
end

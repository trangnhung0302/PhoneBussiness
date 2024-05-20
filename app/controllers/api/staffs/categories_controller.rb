module Api
  module Staffs
    class CategoriesController < Staffs::ApplicationController
      before_action :find_category, only: [:update, :show]
      def index
        @pagy, @categories = pagy(Category.search(params))
      end
      
      def create
        @category = Category.new(request_params)
        @category.save!
      end

      def update
        @category.assign_attributes(request_params)
        @category.save!
      end

      def show
        
      end

      private

      def request_params
        params.permit(
          :name,
        )
      end

      def find_category
        @category = Category.find(params[:id])
        return error_404 if @category.nil?
      end
    end
  end
end

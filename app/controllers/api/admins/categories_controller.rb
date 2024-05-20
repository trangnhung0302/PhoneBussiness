module Api
  module Admins
    class CategoriesController < Admins::ApplicationController
      before_action :find_category, only: [:update, :show]
      def index
        @pagy, @categories = pagy(Category.search(params))
      end
    end
  end
end

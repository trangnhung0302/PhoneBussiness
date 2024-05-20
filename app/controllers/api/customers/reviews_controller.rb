module Api
  module Customers
    class ReviewsController < Customers::ApplicationController
      def create
        order = Order.find(params[:order_id])
        review = order.review
        if review.nil?
          review = Review.new(request_params)
          review.save
        else
          review.update(request_params)
        end
      end

      private

      def request_params
        params.permit(
          :order_id,
          :ratings,
          :review,
        )
      end
    end
  end
end

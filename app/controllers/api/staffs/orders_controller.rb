module Api
  module Staffs
    class OrdersController < Staffs::ApplicationController
      before_action :find_order, only: [:update, :show]
      def index
        @pagy, @orders = pagy(Order.search(params))
      end

      def show
      end

      def update
        @order.assign_attributes(update_params)
        @order.save
      end

      private

      def find_order
        @order = Order.find(params[:id])
      end

      def update_params
        params.permit(:payment_status, :status).merge(staff_id: @current_staff.id)
      end
    end
  end
end

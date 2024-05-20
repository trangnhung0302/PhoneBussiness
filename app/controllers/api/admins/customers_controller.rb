module Api
  module Admins
    class CustomersController < Admins::ApplicationController
      before_action :find_customer, only: [:update, :show]
      def index
        @pagy, @customers = pagy(Customer.search(params))
      end

      def update
        @customer.assign_attributes(request_params)
        @customer.save!
      end

      def show
        
      end

      private

      def request_params
        params.permit(
          :status,
        )
      end

      def find_customer
        @customer = Customer.find(params[:id])
        return error_404 if @customer.nil?
      end
    end
  end
end

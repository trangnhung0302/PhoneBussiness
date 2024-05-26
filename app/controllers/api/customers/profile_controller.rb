module Api
  module Customers
    class ProfileController < Customers::ApplicationController
      def index
      end

      def update
        @customer = Customer.find(params[:id])
        @customer.update(request_params)
      end

      private

      def request_params
        params.permit(
          :name,
          :email,
          :phone
        )
      end
    end
  end
end

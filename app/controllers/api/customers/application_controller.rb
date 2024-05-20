module Api
  module Customers
    class ApplicationController < Api::ApplicationController
      before_action :set_default_request_format, :authorize_access_request!, :current_customer
      
      private

      def current_customer
        @current_customer ||= Customer.find(payload['customer_id'])
      end
    end
  end
end

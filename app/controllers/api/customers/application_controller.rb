module Api
  module Customers
    class ApplicationController < Api::ApplicationController
      before_action :set_default_request_format, :authorize_access_request!, :current_customer
      
      private

      def current_customer
        @current_customer ||= Customer.find(payload['customer_id'])
      end

      def push_notifycation notice_message
        pusher = Pusher::Client.new(
          app_id: '1808750',
          key: '0cee147bf16c7ab7dd86',
          secret: '26658265e707bb379d63',
          cluster: 'ap1',
          encrypted: true
        )
        
        pusher.trigger('phone-bussiness-development', 'customer-order', notice_message)
      end
    end
  end
end

module Api
  module Customers
    class OrderCancelReasonsController < Customers::ApplicationController
      def index
        @order_cancel_reasons = OrderCancelReason.all
      end
    end
  end
end

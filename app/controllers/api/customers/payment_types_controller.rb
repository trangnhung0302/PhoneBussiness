module Api
  module Customers
    class PaymentTypesController < Customers::ApplicationController
      def index
        @payment_types = PaymentType.all
      end
    end
  end
end

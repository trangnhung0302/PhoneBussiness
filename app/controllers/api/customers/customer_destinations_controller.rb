module Api
  module Customers
    class CustomerDestinationsController < Customers::ApplicationController
      def index
        @customer_destinations = CustomerDestination.where(customer_id: @current_customer.id, is_deleted: false)
      end

      def create
        default = CustomerDestination.find_by(customer_id: @current_customer.id, is_deleted: false).nil?
        p default
        @customer_destination = CustomerDestination.new(request_params)
        @customer_destination.customer_id = @current_customer.id
        @customer_destination.default = default
        @customer_destination.save
      end

      def update
        @customer_destination = CustomerDestination.find(params[:id])
        @customer_destination.assign_attributes(request_params);
        @customer_destination.save
      end

      def destroy
        @customer_destination = CustomerDestination.find(params[:id])
        @customer_destination.update(is_deleted: true)
        @customer_destination.save
      end

      private

      def request_params
        params.permit(
          :recipient_name,
          :recipient_phone,
          :province_id,
          :province_name,
          :district_id,
          :district_name,
          :ward_code,
          :ward_name,
          :address,
          :default,
        )
      end
    end
  end
end

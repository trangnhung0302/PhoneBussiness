module Api
  module Customers
    class CartsController < Customers::ApplicationController
      def index
        @carts = Cart.where(customer_id: @current_customer.id)
        @carts = @carts.where(id: params[:cart_ids]) if params[:cart_ids].present?
      end

      def create
        @cart = Cart.find_by(customer_id: @current_customer.id, item_id: params[:item_id], item_color_id: params[:item_color_id])
        if @cart.nil?
          @cart = Cart.create(request_params)
        else
          @cart.update(quantity: @cart.quantity + params[:quantity])
        end
      end

      def update_carts
        ActiveRecord::Base.transaction do
          update_carts_params[:carts].each do |update_cart_params|
            cart = Cart.find(update_cart_params['id'])
            cart.assign_attributes(update_cart_params)
            cart.quantity > 0 ? cart.save : cart.destroy
          end
        end
      end

      private

      def request_params
        params.permit(
          :item_id,
          :quantity,
          :item_color_id
        ).merge(customer_id: current_customer.id)
      end

      def update_carts_params
        params.require(:params).permit(
          carts: [:id, :quantity]
        )
      end
    end
  end
end

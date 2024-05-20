module Api
  module Customers
    class OrdersController < Customers::ApplicationController
      def index
        @pagy, @orders = pagy(Order.where(customer_id: @current_customer.id).order(created_at: :desc))
      end

      def show
        @order = Order.find(params[:id])
      end

      def create
        order_item_params[:order_items].each do |order_item_params|
          if order_item_params[:item_color_id].present?
            item_color = ItemColor.find(order_item_params[:item_color_id])
            return error_422("#{item_color.item.name} - #{item_color.color} không đủ hàng") if item_color.quantity < order_item_params[:quantity]
          else
            item = Item.find(order_item_params[:item_id])
            return error_422("#{item.name} không đủ hàng") if item.quantity < order_item_params[:quantity]
          end
        end
        @order = Order.new(request_params)
        total_price = 0
        @order.total_price = total_price
        ActiveRecord::Base.transaction do
          @order.save!
          order_item_params[:order_items].each do |order_item_params|
            if (order_item_params[:cart_id].present?)
              Cart.find(order_item_params[:cart_id]).destroy
            end
            if order_item_params[:item_color_id].present?
              item = ItemColor.find(order_item_params[:item_color_id])
            else
              item = Item.find(order_item_params[:item_id])
            end
            item.quantity -= order_item_params[:quantity]
            item.save
            total_price += item.price.to_i * order_item_params[:quantity]
            order_item = @order.order_items.new()
            order_item.item_id = order_item_params[:item_id]
            order_item.item_color_id = order_item_params[:item_color_id]
            order_item.quantity = order_item_params[:quantity]
            order_item.price = item.price
            order_item.purchase_price = item.purchase_price
            order_item.save
          end
          @order.update(total_price: total_price)
        end
      end

      def update
        @order = Order.find(params[:id])
        if @order.payment_status == :unpaid && update_params[:payment_status].present?
          @order.update(payment_status: update_params[:payment_status])
        end

        if update_params[:status].present? && @order.status == :wait_confirm && @order.payment_status == :unpaid
          @order.update(status: update_params[:status], order_cancel_reason_id: params[:order_cancel_reason_id])
        end
      end

      private

      def update_params
        params.permit(
          :payment_status,
          :status,
          :order_cancel_reason_id,
        )
      end

      def request_params
        params.permit(
          :payment_type_id,
          :transport_service_id,
          :transport_service_name,
          :customer_destination_id,
          :ship_amount,
          :message,
        ).merge(customer_id: current_customer.id)
      end

      def order_item_params
        params.permit(
          order_items: [:cart_id, :item_id, :quantity, :item_color_id]
        )
      end
    end
  end
end

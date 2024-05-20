module Api
  module Admins
    class ReportsController < Admins::ApplicationController
      def report_revenue
        set_params_date
        @calculate_order_first = Order.calculate_revenue(@date_start_first, @date_end_first).first()
        @calculate_order_second = Order.calculate_revenue(@date_start_second, @date_end_second).first()
        p @date_start_second
        p @date_end_second
        @calculate_order_third = Order.calculate_revenue(@date_start_third, @date_end_third).first()
      end

      def report_by_category
        set_params_date_current
        @category_orders = Order.count_category_order(@date_start, @date_end)
      end

      def report_by_supplier
        set_params_date_current
        @supplier_orders = Order.count_supplier_order(@date_start, @date_end)
      end

      private

      def set_params_date
        case params[:type_search_time]
        when Order::SEARCH_BY_MONTH
          set_params_date_by_month
        when Order::SEARCH_BY_YEAR
          set_params_date_by_year
        when Order::SEARCH_BY_RANGE
          set_params_date_by_range
        end
      end

      def set_params_date_current
        case params[:type_search_time]
        when Order::SEARCH_BY_MONTH
          @date_start = Time.zone.parse("#{params[:month]}").beginning_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')
          @date_end = Time.zone.parse("#{params[:month]}").end_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')
        when Order::SEARCH_BY_YEAR
          @date_start = Time.zone.parse("#{params[:year]}").beginning_of_year.utc.strftime('%Y-%m-%d %H:%M:%S')
          @date_end = Time.zone.parse("#{params[:year]}").end_of_year.utc.strftime('%Y-%m-%d %H:%M:%S')
        when Order::SEARCH_BY_RANGE
          @date_start = Time.zone.parse("#{params[:start_time]}").beginning_of_day.utc.strftime('%Y-%m-%d %H:%M:%S')
          @date_end = Time.zone.parse("#{params[:end_time]}").end_of_day.utc.strftime('%Y-%m-%d %H:%M:%S')
        end
      end

      def set_params_date_by_month
        @date_start_first = Time.zone.parse("#{params[:month]}").beginning_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')
        @date_end_first = Time.zone.parse("#{params[:month]}").end_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')

        @date_start_second = (Time.zone.parse("#{params[:month]}") - 1.month).beginning_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')
        @date_end_second = (Time.zone.parse("#{params[:month]}") - 1.month).end_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')

        @date_start_third = (Time.zone.parse("#{params[:month]}") - 2.month).beginning_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')
        @date_end_third = (Time.zone.parse("#{params[:month]}") - 2.month).end_of_month.utc.strftime('%Y-%m-%d %H:%M:%S')
      end

      def set_params_date_by_year
        @date_start_first = Time.zone.parse("#{params[:year]}").beginning_of_year.utc.strftime('%Y-%m-%d %H:%M:%S')
        @date_end_first = Time.zone.parse("#{params[:year]}").end_of_year.utc.strftime('%Y-%m-%d %H:%M:%S')

        @date_start_second = (Time.zone.parse("#{params[:year]}") - 1.year).beginning_of_year.utc.strftime('%Y-%m-%d %H:%M:%S')
        @date_end_second = (Time.zone.parse("#{params[:year]}") - 1.year).end_of_year.utc.strftime('%Y-%m-%d %H:%M:%S')

        @date_start_third = (Time.zone.parse("#{params[:year]}") - 2.year).beginning_of_year.utc.strftime('%Y-%m-%d %H:%M:%S')
        @date_end_third = (Time.zone.parse("#{params[:year]}") - 2.year).end_of_year.utc.strftime('%Y-%m-%d %H:%M:%S')
      end

      def set_params_date_by_range
        @date_start_first = Time.zone.parse("#{params[:start_time]}").beginning_of_day.utc.strftime('%Y-%m-%d %H:%M:%S')
        @date_end_first = Time.zone.parse("#{params[:end_time]}").end_of_day.utc.strftime('%Y-%m-%d %H:%M:%S')
      end
    end
  end
end

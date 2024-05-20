module Api
  module Admins
    class StaffsController < Admins::ApplicationController
      before_action :find_staff, only: [:update, :show]
      def index
        @pagy, @staffs = pagy(Staff.search(params))
      end
      
      def create
        @staff = Staff.new(request_params)
        if @staff.save!
        else
          render json: @staff.error_messages.full_messages, status: :unprocessable_entity
        end
      end

      def update
        @staff.assign_attributes(request_params)
        @staff.save!
      end

      def show
        
      end

      private

      def request_params
        params.permit(
          :name,
          :email,
          :password,
          :phone,
          :status,
        )
      end

      def find_staff
        @staff = Staff.find(params[:id])
        return error_404 if @staff.nil?
      end
    end
  end
end

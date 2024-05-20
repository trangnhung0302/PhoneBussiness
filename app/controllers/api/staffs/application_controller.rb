module Api
  module Staffs
    class ApplicationController < Api::ApplicationController
      before_action :set_default_request_format, :authorize_access_request!, :current_staff
      
      private

      def current_staff
        @current_staff ||= Staff.find(payload['staff_id'])
      end
    end
  end
end

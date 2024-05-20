module Api
  module Admins
    class ApplicationController < Api::ApplicationController
      before_action :set_default_request_format, :authorize_access_request!, :current_admin
      
      private

      def current_admin
        @current_admin ||= Admin.find(payload['admin_id'])
      end
    end
  end
end

module Api
  module Admins
    class SessionsController < Api::SessionsController
      def create
        @user_data = {
          email: params[:email] || '',
          password: ''
        }
        if params[:email].present? && params[:email].present?
          @admin = Admin.find_by(email: params[:email])
          if !@admin.nil? && @admin.authenticate(params[:password])
            session[:admin_id] = nil
            session[:admin_id] = @admin.id
            payload = { admin_id: @admin.id }
            session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
            tokens = session.login
            response.set_cookie(JWTSessions.access_cookie,
                                value: tokens[:access],
                                httponly: true,
                                secure: Rails.env.production?)
            render json: { csrf: tokens[:access] }
          else
            not_authorized
          end
        else
          not_authorized
        end
      end
    end
  end
end

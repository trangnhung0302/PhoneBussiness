module Api
  module Customers
    class SessionsController < Api::SessionsController
      def create
        @user_data = {
          email: params[:email] || '',
          password: ''
        }
        if params[:email].present? && params[:email].present?
          @customer = Customer.find_by(email: params[:email], status: :active)
          if !@customer.nil? && @customer.authenticate(params[:password])
            session[:customer_id] = nil
            session[:customer_id] = @customer.id
            payload = { customer_id: @customer.id }
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

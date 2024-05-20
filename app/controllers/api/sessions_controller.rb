module Api
  class SessionsController < ActionController::Base
    protect_from_forgery with: :null_session
    include JWTSessions::RailsAuthorization
    include ErrorResponseGenerateable
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
    skip_before_action :verify_authenticity_token
    before_action :authorize_access_request!, only: [:destroy]

    def destroy
      session = JWTSessions::Session.new(payload: payload)
      session.flush_by_access_payload
      render json: :ok
    end

    def check_token
      authorize_access_request!
    end

    private

    def not_authorized
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end
end

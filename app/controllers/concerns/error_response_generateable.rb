# rubocop:disable Naming/VariableNumber
module ErrorResponseGenerateable
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :error_500 unless Rails.env.development? || Rails.env.test?
    rescue_from ActiveRecord::RecordNotFound, with: :error_404
    rescue_from ActiveRecord::RecordInvalid, with: :error_400
    rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  end

  def error_422(error_message)
    error_response = {
      result: {
        status: 'NG',
        message: error_message
      }
    }
    render json: error_response, status: :unprocessable_entity
  end

  def error_400(error_message)
    error_response = {
      result: {
        status: 'NG',
        message: error_message
      }
    }
    render json: error_response, status: :bad_request
  end

  def error_401
    error_response = {
      result: {
        status: 'NG',
        message: 'Unauthorized'
      }
    }
    render json: error_response, status: :unauthorized
  end

  def error_403
    error_response = {
      result: {
        status: 'NG',
        message: 'Forbidden'
      }
    }
    render json: error_response, status: :forbidden
  end

  def error_404
    error_response = {
      result: {
        status: 'NG',
        message: 'Not Found'
      }
    }
    render json: error_response, status: :not_found
  end

  def error_500(error)
    Rails.logger.error(error)
    Raven.capture_exception(error) if Rails.env.production?
    error_response = {
      result: {
        status: 'NG',
        message: 'Internal Server Error'
      }
    }
    render json: error_response, status: :internal_server_error
  end

  def error_validation(error_message)
    @status = 'NG'
    @message = error_message
    render template: 'api/layouts/error', status: :ok
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
# rubocop:enable Naming/VariableNumber

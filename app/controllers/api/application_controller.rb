module Api
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    include ErrorResponseGenerateable
    include JWTSessions::RailsAuthorization
    include Pagy::Backend
    helper_method %i[pager_meta]
    skip_before_action :verify_authenticity_token
  
    def pager_meta(pagy)
      {
        page: pagy.page,
        page_count: pagy.pages,
        page_size: pagy.items,
        item_count: pagy.count
      }
    end

    private

    def set_default_request_format
      request.format = :json
    end
  end
end

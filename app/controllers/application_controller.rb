class ApplicationController < ActionController::API
  #before_action :authenticate_devise_api_token!
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def record_invalid(errors)
    response_by_error(errors: errors.record.errors.full_messages, status: 422)
  end

  def response_by_error(errors:, status: )
    render json: {
      errors: errors,
      status: status
    }, status: status
  end

  def current_user
    if current_devise_api_token
      current_devise_api_token.resource_owner
    end
  end
end

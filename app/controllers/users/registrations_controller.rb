# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def create
    user = User.new user_params
    if user.save
      render json: {
        messages: "Sign Up Successfully",
        is_success: true,
        data: {user: user}
      }, status: :ok
    else
      render json: {
        messages: "Sign Up Failded",
        is_success: false,
        data: {}
      }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def ensure_params_exist
    return if params[:user].present?
    render json: {
      messages: "Missing Params",
      is_success: false,
      data: {}
    }, status: :bad_request
  end
end

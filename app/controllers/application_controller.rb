class ApplicationController < ActionController::Base

  before_action :configure_permit_parameters, if: :devise_controller?

  def configure_permit_parameters
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(:password, :password_confirmation, :current-password)
    }
  end
end

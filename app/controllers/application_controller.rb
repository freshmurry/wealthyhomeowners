class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def after_sign_in_path_for(resource_or_scope)
    current_user #Current User Profile Page
    # dashboard_path #Dashboard
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :phone_number, :description, :image])
  end
end
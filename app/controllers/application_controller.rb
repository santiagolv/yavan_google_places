class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:name, :father_last_name, :mother_last_name, :middle_name, :phone_number, :mobile_number])

    devise_parameter_sanitizer.permit(:account_update, :keys => [:name, :father_last_name, :mother_last_name, :middle_name, :phone_number, :mobile_number])
  end
end

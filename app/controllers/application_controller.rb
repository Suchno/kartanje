class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters_and_time, if:  :devise_controller?


  protected

  def configure_permitted_parameters_and_time
    ENV["TZ"] = "Berlin"
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

  end
end

class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do
    head :not_found, status: :not_found
  end

  # rescue_from Pundit::NotAuthorizedError do |exception|
  #   redirect_to root_url, alert: exception.message
  # end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def after_sign_in_path_for(_resource)
    current_user
  end
end

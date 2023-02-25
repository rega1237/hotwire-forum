class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user, if: :user_signed_in?
  before_action :set_notifications, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name last_name username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name last_name username])
  end

  private

  def set_current_user
    Current.user = current_user
  end

  def set_notifications
    @notifications = Current.user.notifications.reverse
  end
end

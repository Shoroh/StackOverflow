class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def check_permissions(object)
    unless object.user == current_user
      respond_to do |format|
        format.html { redirect_to root_path, flash: {alert: "You don't have permission to manage this #{object.class.to_s.downcase}!"}}
        format.js { growl("You don't have permission to manage this #{object.class.to_s.downcase}!", ["theme: 'growl_alert'"]) }
      end
    end
  end

  def growl(message, *options)
    render template: 'shared/growl', locals: {message: message, options: options}, format: :js
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

end

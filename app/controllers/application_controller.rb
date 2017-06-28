class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_url_history, :except => :back
  protect_from_forgery with: :exception
  def authenticate_user
    if current_user.blank?
     redirect_to new_user_session_path
    end
  end

  def authenticate_admin
    if current_user.blank?
     redirect_to new_user_session_path
   end
  end

  def after_sign_in_path_for(resource)
    if user_signed_in? and (current_user.role.name == "Admin" || current_user.role.name == "SuperAdmin")
      admin_users_path
    elsif user_signed_in? and current_user.role.name == "Customer"
      root_path
    end
  end

  def resource_name
    :user
  end

  def set_url_history
    session[:skip_url_history] ||= false
    if session[:skip_url_history]
      session[:skip_url_history] = false
    else
      session[:url_history] ||= []
      session[:url_history] << request.referrer unless session[:url_history].last == request.referrer
      session[:url_history].shift if session[:url_history].length == 10
    end
  end

  def back
    url = session[:url_history].pop
    session[:skip_url_history] = true
    redirect_to (url || "/")
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  helper_method :resource, :resource_name, :devise_mapping

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :username, :first_name, :last_name, :mobile_number, :role])
  end

end

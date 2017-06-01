class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_authentication
    if !logged_in?
      redirect_to login_path
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user

end

class ApplicationController < ActionController::Base
  helper_method :logged_in?
  before_action :current_user

  def welcome
    @user = User.new
  end

  def logged_in?
    session[:user_id]
  end

  private

  def require_logged_in
    redirect_to welcome_path unless logged_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end

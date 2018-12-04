module ApplicationHelper
  def home_path
    if logged_in?
      return user_path(session[:user_id])
    else
      return :welcome
    end
  end

end

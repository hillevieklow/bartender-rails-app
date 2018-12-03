class SessionsController < ApplicationController
  def create
    redirect_to user_path(@current_user.id) if logged_in?
    if auth_hash = request.env["omniauth.auth"]
      @user = User.find_or_create_by_omniauth(auth_hash)
      session[:user_id]=@user.id
      redirect_to user_path(@user)
    else
      @user = User.find_by(email: params[:email].downcase)
      if !@user
        @user = User.new(email: params[:email])
        render :welcome
      elsif @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render :welcome
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to :welcome
  end
end

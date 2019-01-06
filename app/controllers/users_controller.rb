class UsersController < ApplicationController
  before_action :require_logged_in, except: [:new, :create]

  def index
    find_user
    @users = User.all.sort { |a,b| a.name <=> b.name }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    find_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end
end

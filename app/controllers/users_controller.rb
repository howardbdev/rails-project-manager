class UsersController < ApplicationController

  before_action :get_user, only: [:show]
  before_action :require_authentication, only: [:show, :index]

  def index
    @users = User.all
  end

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user
      flash[:alert] = "Error: User already exists with that email.  Check form or log in."
      redirect_to root_path
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Account successfully created!  Welcome aboard, #{@user.name}!"
        redirect_to @user
      else
        flash[:error] = "Error: User not created: " + @user.errors.full_messages.to_sentence
        render :new
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

  def get_user
    @user = User.find_by(id: params[:id])
  end
end

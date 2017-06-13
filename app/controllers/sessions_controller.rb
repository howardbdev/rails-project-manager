class SessionsController < ApplicationController

  def new
    redirect_to root_url if logged_in?
  end

  def create
    @user = User.where("lower(email) = ?", user_params[:email].downcase).first
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = "Email and or password not found.  Please sign up or try again."
      redirect_to login_url
    end
  end

  def destroy
    session.clear
    redirect_to root_url
  end

  private

  def user_params
    params.permit(:name, :email, :password, :role)
  end

end

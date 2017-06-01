class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  private

  def user_params
    params.permit(:name, :email, :password, :role)
  end

end

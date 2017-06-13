class SessionsController < ApplicationController

  def new
    redirect_to root_url if logged_in?
  end

  def create
    if request.env['omniauth.auth']
      user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.password = auth['info']['email']
      end
      if user && user.authenticate(auth['info']['email'])
        session[:user_id] = user.id
        redirect_to user
      else
        flash['error'] = user.errors.full_messages.to_sentence if user.errors
        redirect_to root_url
      end
    else
      @user = User.where("lower(email) = ?", user_params[:email].downcase).first
      if @user && @user.authenticate(user_params[:password])
        session[:user_id] = @user.id
        redirect_to @user
      else
        flash[:error] = "Email and or password not found.  Please sign up or try again."
        redirect_to login_url
      end
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

  def auth
    request.env['omniauth.auth']
  end

end

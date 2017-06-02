class UsersController < ApplicationController

  before_action :get_user, only: [:show, :destroy, :edit, :update, :role_array]
  before_action :require_authentication, only: [:show, :index, :destroy, :edit, :update, :role_array]
  before_action :require_authorization, only: [:destroy, :edit, :update]
  helper_method :role_array

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

  def update
    if @user.update(role: user_params[:role])
      flash[:notice] = "#{@user.name}'s role successfully updated to #{@user.role}!"
    else
      flash[:error] = "Update unsuccessful: " + @user.errors.full_messages.to_sentence
    end
    redirect_to @user
  end

  def destroy
    @user.delete
    flash[:alert] = "Successfully deleted #{@user.name}'s account."
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

  def get_user
    @user = User.find_by(id: params[:id])
  end

  def require_authorization
    if current_user.role_before_type_cast <= @user.role_before_type_cast
      flash[:alert] = "You are not authorized for that function.  Nice try, slick."
      redirect_to @user
    end
  end

  def role_array
    roles = ['worker', 'supervisor', 'admin', 'big_boss']
    roles.select do |role|
      role if roles.index(role) > @user.role_before_type_cast && roles.index(role) <= current_user.role_before_type_cast
    end
  end
end

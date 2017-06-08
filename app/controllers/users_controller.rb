class UsersController < ApplicationController

  before_action :get_user, only: [:show, :destroy, :edit, :update]
  before_action :require_authentication, only: [:show, :index, :destroy, :edit, :update]
  before_action :require_authorization, only: [:edit, :update]
  before_action :must_be_big_boss, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @projects = Project.all
    @assignment = @user.assignments.build
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
    if @user.pet_projects.any?
      @user.pet_projects.each do |project|
        project.update(owner_id: current_user.id)
        current_user.pet_projects << project
      end
      current_user.save
    end
    @user.delete
    flash[:notice] = "Successfully deleted #{@user.name}'s account."
    flash[:alert] = "By the way, you now own all #{@user.name}'s projects!'"
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
    unless current_user.can_edit? @user
      flash[:alert] = "You are not authorized for that function.  Nice try, slick."
      redirect_back(fallback_location: root_path)
    end
  end

  def must_be_big_boss
    unless current_user.big_boss?
      flash[:alert] = "Only a Big Boss can do that!"
      redirect_back(fallback_location: root_path)
    end
  end

end

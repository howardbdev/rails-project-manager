class UsersController < ApplicationController

  before_action :get_user, only: [:show, :destroy, :edit, :update, :role_array]
  # before_action :require_authentication, only: [:show, :index, :destroy, :edit, :update, :role_array]
  # before_action :require_authorization, only: [:edit, :update]
  before_action :must_be_big_boss, only: [:destroy]
  helper_method :role_array

  def index
    q = params[:q]
    @users = User.all
    users = User.where(["name LIKE ?", "%#{q}%"]).limit(100)
    users += User.where(["email LIKE ?", "%#{q}%"]).limit(100)
    respond_to do |format|
      format.html { render :index }
      # format.json { render json: @users }
      # format.json { render json: users }
      format.json { q ? (render json: users) : (render json: @users) }
    end
  end

  def show
    @projects = Project.all
    @assignment = @user.assignments.build
    respond_to do |format|
     format.html { render :show }
     format.json { render json: @user }
   end
  end

  def new
    redirect_to root_url if logged_in?
    @user = User.new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user
      flash[:alert] = "Error: User already exists with that email.  Check form or log in."
      redirect_to root_url
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
    if @user.update(user_params)
      flash[:notice] = "#{@user.name} successfully updated!"
    else
      flash[:error] = "Update unsuccessful: " + @user.errors.full_messages.to_sentence
    end
    redirect_to @user
  end

  def destroy
    current_user.takeover_projects_from(@user)
    @user.delete
    flash[:notice] = "Successfully deleted #{@user.name}'s account."
    flash[:alert] = "By the way, you now own all #{@user.name}'s projects!'"
    redirect_to users_url
  end

  def busiest
    @busiest_worker = User.busiest_worker
    @busiest_project_owner = User.owns_the_most_projects
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :role, :q)
  end

  def get_user
    @user = User.find_by(id: params[:id])
  end

  def require_authorization
    unless current_user.can_edit_user? @user
      flash[:alert] = "You are not authorized for that function.  Nice try, slick."
      redirect_back(fallback_location: root_url)
    end
  end

  def must_be_big_boss
    unless current_user.big_boss?
      flash[:alert] = "Only a Big Boss can do that!"
      redirect_back(fallback_location: root_url)
    end
  end

  def role_array
    roles = ['worker', 'supervisor', 'admin', 'big_boss']
    return roles if current_user.big_boss?
    roles.select do |role|
      role if role != @user.role && current_user.role_before_type_cast >= roles.index(role)
    end
  end
end

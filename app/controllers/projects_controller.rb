class ProjectsController < ApplicationController
  before_action :require_authentication
  before_action :get_user
  before_action :get_project, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy
    @project.delete
    redirect to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :location, :description, :status, :owner_id)
  end

  def get_project
    @project = Project.find_by(id: params[:id])
  end

  def get_user
    @user = User.find_by(id: session[:user_id])
  end

end
  

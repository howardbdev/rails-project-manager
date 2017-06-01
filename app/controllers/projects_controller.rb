class ProjectsController < ApplicationController
  before_action :require_authentication
  before_action :get_project_and_owner, only: [:show, :edit, :update, :destroy]

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

  def get_project_and_owner
    @project = Project.find_by(id: params[:id])
    if @project.nil?
      flash[:error] = "Project not found."
      redirect_to projects_path
    else
      @owner = User.find_by(id: @project.owner_id)
    end
  end

end

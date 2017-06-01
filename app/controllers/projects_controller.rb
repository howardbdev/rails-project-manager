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
    @project = current_user.pet_projects.build(project_params)
    if @project.save
      flash[:notice] = "Project successfully created."
      redirect_to @project
    else
      flash[:error] = @project.errors.full_messages
      render :new
    end
  end

  def edit

  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project successfully updated."
      redirect_to @project
    else
      flash[:error] = @project.errors.full_messages
      render :edit
    end
  end

  def destroy
    @project.delete
    redirect_to projects_path
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

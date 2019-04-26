class ProjectsController < ApplicationController
  before_action :require_authentication
  before_action :get_project, only: [:show, :edit, :update, :destroy]

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @projects = Project.where(owner_id: params[:user_id]) + @user.projects
    else
      @projects = Project.all
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project successfully created."
      redirect_to @project
    else
      flash[:error] = @project.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @note = current_user.notes.build
    @assignment = @project.assignments.build
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project successfully updated."
      redirect_to @project
    else
      flash[:alert] = "Project not updated:"
      flash[:error] = @project.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @project.delete
      flash[:notice] = "Project successfully deleted."
    else
      flash[:alert] = "There was an error processing that request."
      flash[:error] = @project.errors.full_messages.to_sentence
    end
    redirect_to projects_url
  end

  private

  def project_params
    params.require(:project).permit(:name, :location, :description, :status, :owner_id, :due_date, tool_ids: [], tools_attributes: [:name])
  end

  def get_project
    @project = Project.find_by(id: params[:id])
    if @project.nil?
      flash[:error] = "Project not found."
      redirect_to projects_url
    end
  end

end

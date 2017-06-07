class AssignmentsController < ApplicationController
  before_action :require_authentication

  def create
    if params[:user_id]
      @user = User.find_by(params[:user_id])
      assignment = @user.assignments.build(assignment_params)
    else
      @project = Project.find_by(params[:project_id])
      assignment = @project.assignments.build(assignment_params)
    end

    if assignment && assignment.save
      flash[:notice] = "Assignment successfully created."
    else
      flash[:error] = "Assignment failed: " + assignment.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: projects_path)
  end

  def destroy
    if params[:user_id]
      assignment = Assignment.find_by(project_id: assignment_params[:project_id], user_id: params[:user_id])
    else
      assignment = Assignment.find_by(project_id: params[:project_id], user_id: assignment_params[:user_id])
    end

    if assignment && assignment.destroy
      flash[:notice] = "That assignment has been deleted."
    else
      flash[:error] = "There was an error deleting that assignment.. "
    end

    redirect_back(fallback_location: projects_path)
  end

  private

  def assignment_params
    params.require(:assignment).permit(:user_id, :project_id)
  end
end

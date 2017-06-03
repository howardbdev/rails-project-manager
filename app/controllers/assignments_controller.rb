class AssignmentsController < ApplicationController
  before_action :require_authentication

  def create
    if assignment_params[:project]
      assignment = Assignment.new(user_id: assignment_params[:user_id], project_id: assignment_params[:project][:project_id])
    else
      assignment = Assignment.new(project_id: assignment_params[:project_id], user_id: assignment_params[:user][:user_id])
    end

    if assignment.save
      flash[:notice] = "Assignment successfully created."
      redirect_to project_path(assignment.project_id)
    else
      flash[:error] = "Assignment failed: " + assignment.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    assignment = Assignment.find_by(assignment_params)
    if assignment.destroy
      flash[:notice] = "That assignment has been deleted."
    else
      flash[:error] = "There was an error deleting that assignment.. "
    end
    redirect_to projects_path
  end

  private

  def assignment_params
    params.permit(:user_id, {project: :project_id}, :project_id, {user: :user_id})
  end
end

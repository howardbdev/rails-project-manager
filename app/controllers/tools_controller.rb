class ToolsController < ApplicationController
  def index
    if params[:project_id]
      project = Project.find_by(id: params[:project_id])
      @tools = project.tools
    else
      @tools = Tool.all
    end
  end

  def show
    @tool = Tool.find_by(id: params[:id])
  end

  def destroy
    @tool = Tool.find_by(id: params[:id])
    if @tool.delete
      flash[:notice] = "Tool successfully deleted."
    else
      flash[:alert] = "There was an error processing that request."
      flash[:error] = @tool.errors.full_messages.to_sentence if @tool.errors.any?
    end
    redirect_to projects_path
  end
end

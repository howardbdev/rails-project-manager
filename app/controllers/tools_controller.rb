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
end

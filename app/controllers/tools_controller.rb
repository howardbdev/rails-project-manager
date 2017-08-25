class ToolsController < ApplicationController
  before_action :get_tool, only: [:show, :destroy]

  def index
    @tools = Tool.all
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @tool }
    end
  end

  def destroy
    if @tool.delete
      flash[:notice] = "Tool successfully deleted."
    else
      flash[:alert] = "There was an error processing that request."
      flash[:error] = @tool.errors.full_messages.to_sentence if @tool.errors.any?
    end
    redirect_to projects_url
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      flash[:notice] = "Tool successfully created."
      redirect_to @tool
    else
      flash[:alert] = "There was an error creating tool."
      flash[:error] = @tool.errors.full_messages.to_sentence
      redirect_back(fallback_location: tools_url)
    end
  end

  private

  def tool_params
    params.require(:tool).permit(:name, :inventory)
  end

  def get_tool
    @tool = Tool.find_by(id: params[:id])
  end
end

class NotesController < ApplicationController


  def new
    @note = current_user.notes.build
  end

  def create

  end

  def destroy
    @note.delete
    flash[:notice] = "Note successfully deleted."
    redirect_back(fallback_location: projects_path)
  end

  def note_params
    params.permit(:content, :user_id, :project_id)
  end
end

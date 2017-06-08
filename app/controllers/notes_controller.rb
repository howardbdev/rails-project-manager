class NotesController < ApplicationController


  def new
    @note = current_user.notes.build
  end

  def create
    @project = Project.find_by(id: params[:project_id])
    @note = @project.notes.build(note_params)
    @note.user_id = current_user.id
    if @note.save
      flash[:notice] = "Note successfully created."
      redirect_to project_path(@project)
    else
      flash[:alert] = "There was an error saving the note."
      flash[:error] = @note.errors.full_messages.to_sentence
      redirect_back(fallback_location: projects_path)
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if @note && @note.delete
      flash[:notice] = "Note successfully deleted."
    else
      flash[:alert] = "An error prevented the note deletion."
      flash[:error] = @note.errors.full_messages.to_sentence if @note
    end
    redirect_back(fallback_location: projects_path)
  end

  def note_params
    params.require(:note).permit(:content)
  end
end

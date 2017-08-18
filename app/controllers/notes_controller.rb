class NotesController < ApplicationController


  def new
    @note = current_user.notes.build
  end

  def create

    binding.pry

    @project = Project.find_by(id: params[:project_id])
    @note = @project.notes.build(note_params)
    @note.user_id = current_user.id
    success = @note.save

        if success
          flash[:notice] = "Note successfully created."
          # redirect_to project_url(@project)
          render partial: '/projects/note', locals: {project: @project, note: @note}, layout: false
          # render partial: 'new_note', locals: {project: @project, note: @note} if current_user.can_add_note_to?(@project)
        else
          flash[:alert] = "There was an error saving the note."
          flash[:error] = @note.errors.full_messages.to_sentence
          redirect_back(fallback_location: projects_url)
        end
        # if success
        #   flash[:notice] = "Note successfully created."
        #   redirect_to project_url(@project)
        # else
        #   flash[:alert] = "There was an error saving the note."
        #   flash[:error] = @note.errors.full_messages.to_sentence
        #   redirect_back(fallback_location: projects_url)
        # end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if @note && @note.delete
      flash[:notice] = "Note successfully deleted."
    else
      flash[:alert] = "An error prevented the note deletion."
      flash[:error] = @note.errors.full_messages.to_sentence if @note
    end
    redirect_back(fallback_location: projects_url)
  end

  def note_params
    params.require(:note).permit(:content)
  end
end

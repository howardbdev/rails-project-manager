class NotesController < ApplicationController


  def new
    @note = current_user.notes.build
  end

  def create
    @project = Project.find_by(id: params[:project_id])
    @note = @project.notes.build(note_params)
    @note.user_id = current_user.id

    if @note.save
      respond_to do |format|
        format.html { render partial: '/projects/note', locals: {project: @project, note: @note}, layout: false }
        format.json { render json: @note }
      end
    else
      render plain: @note.errors.full_messages.to_sentence, status: 400
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if @note && @note.delete
      render plain: "#note-" + @note.id.to_s, layout: false
    else
      response = @note ? @note.errors.full_messages.to_sentence : ""
      render plain: response, status: 400
    end
  end

  def note_params
    params.require(:note).permit(:content)
  end
end

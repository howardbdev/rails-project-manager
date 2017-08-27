$(function() {
  Note.ready();
})

Note.ready = function() {
  Note.templateSource = $("#note-template").html();
  Note.template = Handlebars.compile(Note.templateSource);
  $(document).on("submit", "#new_note", Note.createNote);
  $(document).on("submit", ".delete-note", Note.deleteNote);
}

function Note(attrs) {
  this.id = attrs.id;
  this.content = attrs.content;
  this.created_at = attrs.created_at;
  this.author = attrs.author;
}

Note.success = function(json) {
  var note = new Note(json);
  var noteLI = note.renderLI();
  $("#notes").append(noteLI);
  $("#note_content").val("");
}

Note.prototype.renderLI = function() {
  return Note.template(this);
}

Note.error = function(response) {
 alert(response.responseText)
}

Note.enableSubmitButton = () => $("#ajax_submit").attr("disabled", false)

Note.createNote = function(e) {
    e.preventDefault();
    const action = this.action;
    const params = $(this).serialize();

    $.post(action, params, () => {}, "json")
      .done(Note.success)
      .fail(Note.error)
      .always(Note.enableSubmitButton)
}

Note.deleteNote = function(e) {
    e.preventDefault();

    $.ajax({
      type: "DELETE",
      url: this.action,
      data: $(this).serialize(),
      success: response => $("li").remove(response),
      error: response => alert("Error deleting note " + response.responseText)
    })
  }

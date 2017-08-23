$(function() {
  Note.ready();
})

Note.ready = function() {
  Note.templateSource = $("#note-template").html();
  Note.template = Handlebars.compile(Note.templateSource);
  $(document).on("submit", "#new_note", ajaxCreateNote);
  $(document).on("submit", ".delete-note", ajaxDeleteNote);
}

function Note(attrs) {
  this.id = attrs.id;
  this.content = attrs.content;
  this.created_at = attrs.created_at;
}

Note.success = function(json) {
  var note = new Note(json);
  var noteLI = note.renderLI();
  $("#notes").append(noteLI);
  $("#note_content").val("");
}

// I'm not sure I need this function - since the delete
// has to be ajax anyway, and the controller isn't going to
// be exposing a delete note API endpoint, I don't think
// there is an advantage.. other than just better code ?
// Note.prototype.removeLI = function() {
//   $("note-" + this.id).remove();
// }

Note.prototype.renderLI = function() {
  return Note.template(this);
}

Note.error = function(response) {
 alert(response.responseText)
}

enableSubmitButton = () => $("#ajax_submit").attr("disabled", false)

ajaxCreateNote = function(e) {
    e.preventDefault();
    const action = this.action;
    const params = $(this).serialize();

    $.post(action, params, () => {}, "json")
      .done(Note.success)
      .fail(Note.error)
      .always(enableSubmitButton)
}

ajaxDeleteNote = function(e) {
    e.preventDefault();

    $.ajax({
      type: "DELETE",
      url: this.action,
      data: $(this).serialize(),
      success: response => $("li").remove(response),
      error: response => alert("Error deleting note " + response.responseText)
    })
  }

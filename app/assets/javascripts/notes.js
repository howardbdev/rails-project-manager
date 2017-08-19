$(function() {
  attachListeners();
})

attachListeners = function() {
  $(document).on("submit", "#new_note", ajaxCreateNote);
  $(document).on("submit", ".delete-note", ajaxDeleteNote);
}

ajaxCreateNote = function(e) {
    e.preventDefault();

    $.post(this.action, $(this).serialize(), function(response) {
      $("#notes").append(response);
      $("#note_content").val("");
    })
    .fail(function(response) {
      alert(response.responseText);
    })
    .always(function() {
      $("#ajax_submit").attr("disabled", false);
    })
}

ajaxDeleteNote = function(e) {
    e.preventDefault();

    $div = this.parentElement.parentElement
    $.ajax({
      type: "DELETE",
      url: this.action,
      data: $(this).serialize(),
      success: function(response){
        console.log("successful deletion " + response.responseText);
        $div.innerHTML = "";
      },
      error: function(response) {
        alert("Error deleting note " + response.responseText);
      }
    })
  }

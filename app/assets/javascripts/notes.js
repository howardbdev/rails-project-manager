$(function() {
  attachListeners();
})

attachListeners = function() {
  $(document).on("submit", "#new_note", ajaxCreateNote);
  $(document).on("submit", ".delete-note", ajaxDeleteNote);
}

ajaxCreateNote = function(e) {
    e.preventDefault()
    const url = this.action;
    const formData = $(this).serialize();

    $.post(url, formData, function(response) {
      $("#notes").append(response);
      $("#note_content").val("");
    })
    .fail(function(response) {
      alert(response.responseText)
    })
    .always(function() {
      $("#ajax_submit").attr("disabled", false);
    })
}

ajaxDeleteNote = function(e) {
    e.preventDefault();
    var data = {
      "authenticity_token": $("#new_note input[name='authenticity_token']").val(),
    }
    var formData = $(this).serialize();

    $div = this.parentElement.parentElement
    $.ajax({
      type: "DELETE",
      url: this.action,
      data: formData,
      success: function(response){
        console.log("successful deletion " + response.responseText)
        $div.innerHTML = "";
      },
      error: function(response) {
        alert("Error deleting note " + response.responseText);
      }
    })
  }

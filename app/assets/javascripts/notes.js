$(function() {
  attachListeners();
})

attachListeners = function() {
  $(document).on("submit", "#new_note", ajaxCreateNote);
  $(document).on("submit", ".delete-note", ajaxDeleteNote);
}

ajaxCreateNote = function(e) {
    e.preventDefault()
    var url = this.action;
    var formData = $(this).serialize();

    console.log(url);
    $.ajax({
      type: "POST",
      url: url,
      data: formData,
      success: function(response){
        $("#notes").append(response);
        $("#ajax_submit").attr("disabled", false);
      },
      error: function(response) {
        alert(response.responseText)
        $("#ajax_submit").attr("disabled", false);
      }
    })
    $("#note_content").val("");
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

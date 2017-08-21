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
      console.log("success!");
      console.log(response);
      debugger;
      $("#notes").append(response);
      $("#note_content").val("");
    }, "json")
    .fail(function(response) {
      console.log("Fail");
      console.log(response);
      alert(response.responseText);
    })
    .always(function() {
      $("#ajax_submit").attr("disabled", false);
    })
}

ajaxDeleteNote = function(e) {
    e.preventDefault();

    $.ajax({
      type: "DELETE",
      url: this.action,
      data: $(this).serialize(),
      success: function(response){
        console.log("successful deletion of " + response);
        $("li").remove(response)
      },
      error: function(response) {
        alert("Error deleting note " + response.responseText);
      }
    })
  }

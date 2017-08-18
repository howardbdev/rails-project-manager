$(function() {

  ajaxCreateNote();
  ajaxDeleteNote();

})

var ajaxCreateNote = function() {
  $("#new_note").on("submit", function(e) {
    e.preventDefault()
    // 1. get the url we need
    // 2. we need the form data
    var url = this.action;
    var data = {
      "authenticity_token": $("#new_note input[name='authenticity_token']").val(),
      "note": {
        "content": $("#note_content").val()
      }
    }
    console.log(data);
    console.log(url);
    $.ajax({
      type: "POST",
      url: url,
      data: data,
      success: function(response){
        $("#notes").append(response)
        $("#ajax_submit").attr("disabled", false);
        ajaxDeleteNote();
      },
      error: function(response) {
        console.log("error reported" + response)
      }
    })
    $("#note_content").val("");

  })
}

var ajaxDeleteNote = function() {
  $(".delete-note").on("submit", function(e) {
    e.preventDefault();
    var data = {
      "authenticity_token": $("#new_note input[name='authenticity_token']").val(),
    }

    $div = this.parentElement.parentElement
    // this.parentElement.parentElement.innerHTML = "";
    $.ajax({
      type: "DELETE",
      url: this.action,
      data: data,
      success: function(response){
        $div.innerHTML = "";
      },
      error: function(response) {
        alert("Note not deleted");
      }
    })

  })
}

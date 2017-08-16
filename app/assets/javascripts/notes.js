$(function() {
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
      },
      error: function(response) {
        debugger
      }
    })
    $("#note_content").val("");
  })
})

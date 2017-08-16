$(function() {
  $("#new_note").on("submit", function(e) {
    e.preventDefault()
    alert("you clicked submit")
    // 1. get the url we need
    // 2. we need the form data
    var data = {
      "authenticity_token": $("#new_note input[name='authenticity_token']").val(),
      "note": {
        "url": this.action,
        "content": $("#note_content").val()
      }
    }
    $.ajax({
      type: "POST",
      url: "url",
      data: data,
      success: function(response){
        debugger
      },
      error: function(response) {
        debugger
      }
    })
  })
})

$(function() {
  Project.ready();
})

Project.ready = function() {
  Project.templateSource = $("#project-template").html();
  Project.template = Handlebars.compile(Project.templateSource);
  $(document).on("submit", ".project-quick-view", Project.showProject);
  // $(document).on("submit", ".delete-note", Project.deleteNote);

}

function Project(attrs) {
  this.id = attrs.id;
  this.description = attrs.description;
  this.location = attrs.location;
  this.status = attrs.status;
  this.owner_id = attrs.owner_id;
  this.due_date = attrs.due_date;
  this.created_at = attrs.created_at;
  this.updated_at = attrs.updated_at;
}

// Project.success = function(json) {
//   var proj = new Project(json);
//   var noteLI = note.renderLI();
//   $("#notes").append(noteLI);
//   $("#note_content").val("");
// }
Project.makeDiv = (json) => {
  console.log(json);
    // var proj = new Project(json);
    // var noteLI = note.renderLI();
    // $("#notes").append(noteLI);

}

Project.error = (resp) => alert(resp.responseText)

Project.showProject = function(e) {
    e.preventDefault();
    const action = this.action;
    const that = this;


    $.get(action, () => {}, "json")
      .done(Project.makeDiv)
      .fail(Project.error)
}

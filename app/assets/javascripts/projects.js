$(function() {
  Project.ready();
})

Project.ready = function() {
  $(document).on("submit", ".project-quick-view", Project.showProject);
  $(document).on("click", ".hide-proj", Project.hide);
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
  this.owner = attrs.owner;
  this.notes = attrs.notes;
  this.workers = attrs.workers;
  this.tools = attrs.tools;
}

Project.showProject = function(e) {
    e.preventDefault();
    const action = this.action;
    const that = this;

    $.get(action, () => {}, "json")
      .done(Project.quickViewDiv)
      .fail(Project.error)
}

Project.quickViewDiv = (json) => {
  console.log(json);
  const proj = new Project(json);
  const projDiv = HandlebarsTemplates['project'](proj);
  $(`#project-quick-view-${json.id}`).append(projDiv);
}

Project.error = (resp) => alert(resp.responseText)

Project.hide = (e) => {
  e.preventDefault();
  e.target.parentElement.parentElement.hidden = true;
}

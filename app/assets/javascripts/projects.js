$(function() {
  Project.ready();
})

Project.ready = function() {
  $(document).on("submit", ".project-quick-view", Project.showProject);
  $(document).on("submit", ".project-index-view", Project.showProjectIndex);
  $(document).on("click", ".hide-proj", Project.hide);
}

function Project(attrs) {
  this.id = attrs.id;
  this.name = attrs.name;
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
      .done(Project.singleQuickViewDiv)
      .fail(Project.error)
}

Project.singleQuickViewDiv = (json) => {
  console.log(json);
  const proj = new Project(json);
  const projDiv = HandlebarsTemplates['project'](proj);
  $(`#project-quick-view-${json.id}`).append(projDiv);
}

Project.error = (resp) => alert(resp.responseText)

Project.showProjectIndex = function(e) {
    e.preventDefault();
    const action = this.action;
    $.get(action, () => {}, "json")
      .done(Project.renderProjectIndex)
      .fail(Project.error)
}

Project.renderProjectIndex = (json) => {
  clearQuickView();
  json.forEach(function(project_json) {
    const project = new Project(project_json);
    const projectDiv = HandlebarsTemplates['project'](project);
    $(`.index-display.quick-view-rt`).append(projectDiv);
  }, this)
}

Project.hide = (e) => {
  e.preventDefault();
  e.target.parentElement.parentElement.hidden = true;
}

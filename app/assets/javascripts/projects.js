$(function() {
  Project.ready();
})

Project.ready = function() {
  Project.templateSource = $("#project-template").html();
  Project.template = Handlebars.compile(Project.templateSource);
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
  this.tools = attrs.tools;
}

Project.prototype.renderDiv = function() {
  return Project.template(this);
}

Project.quickViewDiv = (json) => {
  console.log(json);
    const proj = new Project(json);
    const projDiv = proj.renderDiv();
    $(`#project-quick-view-${json.id}`).append(projDiv);
}

Project.hide = (e) => {
  e.preventDefault();
  e.target.parentElement.parentElement.hidden = true;
}

Project.error = (resp) => alert(resp.responseText)

Project.showProject = function(e) {
    e.preventDefault();
    const action = this.action;
    const that = this;


    $.get(action, () => {}, "json")
      .done(Project.quickViewDiv)
      .fail(Project.error)
}

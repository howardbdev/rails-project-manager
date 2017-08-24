$(function() {
  Project.ready();
})

Project.ready = function() {

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

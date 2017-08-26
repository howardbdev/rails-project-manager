function User(attrs) {
  this.id = attrs.id;
  this.name = attrs.name;
  this.email = attrs.email;
  this.role = attrs.role;
  this.created_at = attrs.created_at;
  this.updated_at = attrs.updated_at;
  this.projects = attrs.projects;
  this.pet_projects = attrs.pet_projects;
}

$(function() {
  User.ready();
})

User.ready = function() {
  User.templateSource = $("#user-template").html();
  User.template = Handlebars.compile(User.templateSource);
  $(document).on("submit", ".user-quick-view", User.showUser);
  $(document).on("click", ".hide-proj", User.hide);
}

User.prototype.renderDiv = function() {
  return User.template(this);
}

User.showUser = function(e) {
    e.preventDefault();
    const action = this.action;
    const that = this;

    $.get(action, () => {}, "json")
      .done(User.quickViewDiv)
      .fail(User.error)
}

User.quickViewDiv = (json) => {
  json.forEach(function(user_json) {
    console.log(json);
    const user = new User(user_json);
    const userDiv = user.renderDiv();
    $(`.user-display.quick-view-rt`).append(userDiv);
  }, this)
}

User.error = (resp) => alert(resp.responseText)

User.hide = (e) => {
  e.preventDefault();
  e.target.parentElement.parentElement.hidden = true;
}

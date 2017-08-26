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
  $(document).on("submit", ".user-quick-view", User.showUser);
  $(document).on("click", "#clear-quick-view-button", User.clearQuickView);
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
    const userDiv = HandlebarsTemplates['user'](user_json);
    $(`.user-display.quick-view-rt`).append(userDiv);
  }, this)
}

User.clearQuickView = (e) => {
  e.preventDefault();
  $(`.user-display.quick-view-rt`).html("");
}

User.error = (resp) => alert(resp.responseText)

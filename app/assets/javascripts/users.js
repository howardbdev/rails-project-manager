$(function() {
  User.ready();
})

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

User.ready = function() {
  $(document).on("submit", ".user-quick-view", User.userIndex);
  $(document).on("click", "#clear-quick-view-button", clearQuickView);
}

User.userIndex = function(e) {
    e.preventDefault();
    const action = this.action;

    $.get(action, () => {}, "json")
      .done(User.renderUserIndex)
      .fail(User.error)
}

User.renderUserIndex = (json) => {
  clearQuickView();
  json.forEach(function(user_json) {
    const user = new User(user_json);
    const userDiv = HandlebarsTemplates['user'](user);
    $(`.index-display.quick-view-rt`).append(userDiv);
  }, this)
}

User.error = (resp) => alert(resp.responseText)

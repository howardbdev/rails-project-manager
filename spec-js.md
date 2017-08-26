# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.

  -> Project quick view from user show renders project view from API endpoint  via AMS JSON backend

- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.

  -> User and Project indexes now available as quick views from user profile page using AMS JSON backend API
  
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.

  -> Project has many notes and workers

- [x] Use your Rails API and a form to create a resource and render the response without a page refresh.

  -> Notes are created and rendered without page refresh  

- [x] Translate JSON responses into js model objects.

  -> JS Note model objects are created from JSON responses

- [x] At least one of the js model objects must have at least one method added by your code to the prototype.

  -> Note.prototype.renderLI

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message

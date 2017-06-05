# User
  has_many :pet_projects, source: :project
  has_many :projects, through: :assignments
  has_many :notes

  @name
  @email
  @password (using bcrypt)

  enum :role [:admin, :supervisor, :worker]

# Project
  belongs_to :owner, source: :user
  has_many :workers, through: :assignments, source: :user

  @description
  @location
  @status

# Assignment
  belongs_to :user
  belongs_to :assignment

# Note
  belongs_to :author, source: :user
  belongs_to :project

  @content

  ## TO DO

  # DO THIS MONDAY!!!! YES!!!! __________________________
  # Record walkthrough
  # Write blog
  # Submit the damn thing!
  # _____________________________________________________

  # Add notes
    allow workers to submit notes on any of their projects
    display notes, but only on project show page
    notes should show up in order with timestamps - basically updates on the project
    any worker can add notes, any sup/admin/boss can add notes as long as project owner is a subordinate

  # Add enum status to projects
    incomplete, submitted for review, complete, overdue
    any overdue projects should show in red
    any worker can submit for review, project owner or any supervisor can confirm
    once projects are confirmed complete, show elsewhere maybe, or style differently?

  # Allow more editing of users?

  # extract logic to models

  # use more forms/partials

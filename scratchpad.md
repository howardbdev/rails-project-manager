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

class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :assignments, dependent: :destroy
  has_many :workers, through: :assignments, source: :user, class_name: "User"
  has_many :notes, dependent: :destroy
  has_many :project_tools, dependent: :destroy
  has_many :tools, through: :project_tools

  validates :name, :location, :description, presence: true
  accepts_nested_attributes_for :notes

  def formatted_due_date
    self.due_date.strftime("%A, %B %d, %Y, at %I:%M %p")
  end

  def overdue?
    Time.now > self.due_date
  end

  def available_workers
    User.all.select {|user| !user.projects.include?(self) && self.owner != user}
  end

  def workers_available_to(current_user)
    current_user.subordinates & self.available_workers
  end

  def assigned_subordinates(current_user)
    current_user.subordinates & self.workers
  end

end

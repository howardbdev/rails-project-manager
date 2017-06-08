class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: {case_sensitive: false}
  has_many :pet_projects, class_name: "Project", foreign_key: "owner_id"
  has_many :assignments, dependent: :destroy
  has_many :projects, through: :assignments
  has_many :notes, dependent: :destroy

  has_secure_password
  enum role: [:worker, :supervisor, :admin, :big_boss]

  def subordinates
    User.all.select {|user| self.outranks?(user)}
  end

  def outranks?(other_user)
    self.role_before_type_cast > other_user.role_before_type_cast
  end

  def can_edit?(project)
    self.big_boss? || self.outranks?(project.owner) || self == project.owner
  end

  def can_edit?(other_user)
    self.outranks?(other_user) || self == other_user
  end

  def can_add_note_to?(project)
    self.can_edit?(project) || project.workers.include?(self)
  end

  def editable_projects
    Project.all.select {|project| self.can_edit?(project)}
  end

  def available_projects
    Project.all.select {|project| !project.workers.include?(self) && project.owner != self}
  end

  def projects_available_to(current_user)
    self.available_projects & current_user.editable_projects
  end

  def assigned_projects_available_to(current_user)
    self.projects & current_user.editable_projects
  end

end

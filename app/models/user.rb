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

  def can_edit_project?(project)
    self.big_boss? || self.outranks?(project.owner) || self == project.owner
  end

  def can_edit_user?(other_user)
    self.outranks?(other_user) || self == other_user
  end

  def can_add_note_to?(project)
    self.can_edit_project?(project) || project.workers.include?(self)
  end

  def editable_projects
    Project.all.select {|project| self.can_edit_project?(project)}
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

  def assigned_projects_count
    self.projects.count
  end

  def pet_projects_count
    self.pet_projects.count
  end

  def takeover_projects_from(old_owner)
    if old_owner.pet_projects.any?
      old_owner.pet_projects.each do |project|
        project.update(owner_id: self.id)
        self.pet_projects << project
      end
      self.save
    end
  end

  def self.busiest_worker
    return nil if User.count == 0
    busiest = User.first
    User.all.each do |user|
      busiest = user if user.assigned_projects_count > busiest.assigned_projects_count
    end
    busiest
  end

  def self.owns_the_most_projects
    return nil if User.count == 0
    ownest = User.first
    User.all.each do |user|
      ownest = user if user.pet_projects_count > ownest.pet_projects_count
    end
    ownest
  end

end

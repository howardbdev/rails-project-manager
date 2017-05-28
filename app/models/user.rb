class User < ApplicationRecord
  has_many :pet_projects, class_name: "Project", foreign_key: "owner_id"
  has_many :assignments
  has_many :projects, through: :assignments
  has_secure_password
  enum role: [:worker, :supervisor, :admin]
end

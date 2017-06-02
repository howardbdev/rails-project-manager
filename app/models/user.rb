class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  has_many :pet_projects, class_name: "Project", foreign_key: "owner_id"
  has_many :assignments, dependent: :destroy
  has_many :projects, through: :assignments
  has_secure_password
  enum role: [:worker, :supervisor, :admin, :big_boss]
end

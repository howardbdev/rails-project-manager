class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :assignments
  has_many :workers, through: :assignments, source: :user, class_name: "User"

  validates :name, :location, :description, presence: true
end

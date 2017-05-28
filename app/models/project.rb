class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :assignments
  has_many :workers, through: :assignments, class_name: "User"
end

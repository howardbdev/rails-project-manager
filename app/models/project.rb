class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :assignments, dependent: :destroy
  has_many :workers, through: :assignments, source: :user, class_name: "User"
  has_many :notes, dependent: :destroy

  validates :name, :location, :description, presence: true
end

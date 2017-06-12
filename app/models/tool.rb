class Tool < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}

  has_many :project_tools, dependent: :destroy
  has_many :projects, through: :project_tools
end

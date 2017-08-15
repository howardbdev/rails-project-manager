class Tool < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}

  has_many :project_tools, dependent: :destroy
  has_many :projects, through: :project_tools

  def self.available_tools
    Tool.all.select { |tool| tool.available? }
  end

  def self.unavailable_tools
    Tool.all.select { |tool| !tool.available? }
  end

  def number_in_use
    self.project_tools.sum(:quantity)
  end

  def available?
    binding.pry
    self.inventory > self.number_in_use
  end

  def number_available
    self.inventory - self.number_in_use
  end
end

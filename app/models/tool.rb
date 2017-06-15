class Tool < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}

  has_many :project_tools, dependent: :destroy
  has_many :projects, through: :project_tools

  def self.available_tools
    Tool.all.select { |tool| tool.available? }
  end

  def number_in_use
    project_tools = ProjectTool.select {|project_tool| project_tool.tool_id == self.id}
    sum = 0
    project_tools.each {|pt| sum += pt.quantity}
    sum
  end

  def available?
    self.inventory > self.number_in_use
  end

  def number_available
    self.inventory - self.number_in_use
  end
end

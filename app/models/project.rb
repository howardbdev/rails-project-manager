class Project < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :assignments, dependent: :destroy
  has_many :workers, through: :assignments, source: :user, class_name: "User"
  has_many :notes, dependent: :destroy
  has_many :project_tools, dependent: :destroy
  has_many :tools, through: :project_tools

  validates :name, :location, :description, presence: true
  accepts_nested_attributes_for :notes

  def tools_attributes=(attributes_hashes)
    attributes_hashes.each do |index_key, attribute_hash|
      tool = Tool.find_or_create_by(name: attribute_hash[:name], inventory: attribute_hash[:inventory])
      self.project_tools.build(tool: tool)
    end
  end

  def formatted_due_date
    self.due_date.strftime("%A, %B %d, %Y, at %I:%M %p")
  end

  def overdue?
    Time.now > self.due_date
  end

  def available_workers
    User.all.select {|user| !user.projects.include?(self) && self.owner != user}
  end

  def workers_available_to(current_user)
    current_user.subordinates & self.available_workers
  end

  def assigned_subordinates(current_user)
    current_user.subordinates & self.workers
  end

  def unique_tool_count
    self.tools.count
  end

  def total_tool_count
    self.project_tools.sum(:quantity)
  end

  def specific_tool_count(tool)
    t = self.project_tools.find_by(tool_id: tool.id)
    t ? t.quantity : 0
  end

end

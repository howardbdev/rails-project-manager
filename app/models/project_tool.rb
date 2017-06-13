class ProjectTool < ApplicationRecord
  belongs_to :project
  belongs_to :tool

  validates :project_id, :tool_id, presence: true
end

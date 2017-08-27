class NoteSerializer < ActiveModel::Serializer
  attributes :id, :content, :author, :project_id, :user_id, :created_at, :updated_at
  belongs_to :project
end

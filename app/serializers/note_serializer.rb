class NoteSerializer < ActiveModel::Serializer
  attributes :id, :content, :project_id, :user_id, :created_at, :updated_at
  belongs_to :project 
end

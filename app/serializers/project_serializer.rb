class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :description, :location, :status, :due_date, :created_at, :updated_at
  belongs_to: :user, serializer: UserSerializer
end

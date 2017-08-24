class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :name, :description, :location, :status, :due_date, :created_at, :updated_at

  belongs_to :owner, serializer: UserSerializer
  has_many :workers, serializer: UserSerializer
  has_many :notes

end

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :name, :description, :location, :status, :due_date, :created_at, :updated_at

  belongs_to :owner
  has_many :workers
  has_many :notes
  has_many :tools

end

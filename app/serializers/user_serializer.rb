class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :created_at, :updated_at
  has_many :projects
  has_many :pet_projects
end

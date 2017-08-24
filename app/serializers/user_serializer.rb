class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :projects, :created_at, :updated_at
end

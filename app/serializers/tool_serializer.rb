class ToolSerializer < ActiveModel::Serializer
  attributes :id, :name, :inventory, :created_at, :updated_at
end

class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_url, :position
  has_many :tasks
end

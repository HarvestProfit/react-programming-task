class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_url
  has_many :tasks
end

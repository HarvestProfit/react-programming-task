class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :project_id, :completed
end

class Task < ApplicationRecord
  belongs_to :project
  has_one :user, through: :project

  acts_as_list scope: [:project_id]
end

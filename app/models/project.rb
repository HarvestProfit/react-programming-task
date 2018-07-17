class Project < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  acts_as_list scope: [:user_id]
end

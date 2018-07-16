class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects
  has_secure_password
end

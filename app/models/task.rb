class Task < ApplicationRecord
  belongs_to :user
  has_many :steps
  has_many :executions
end

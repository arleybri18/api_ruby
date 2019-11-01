class Task < ApplicationRecord
  belongs_to :user
  has_many :steps, dependent: :delete_all
  has_many :executions, dependent: :delete_all
end

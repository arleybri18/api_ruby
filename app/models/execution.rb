class Execution < ApplicationRecord
  belongs_to :task
  serialize :result, Hash
end

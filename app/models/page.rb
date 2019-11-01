class Page < ApplicationRecord
    has_many :steps, dependent: :delete_all
end

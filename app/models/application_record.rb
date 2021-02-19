class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  scope :ordered_by_created_at, -> { order("created_at DESC") }
end

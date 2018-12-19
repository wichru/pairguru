class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates_presence_of :user, :movie, uniqueness: { scope: %i[movie user] }

  scope :persisted, -> { where.not(id: nil) }
end

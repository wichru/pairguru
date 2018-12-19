class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, presence: true
  validates :user, :movie, presence: true
  validates :user, uniqueness: { scope: :movie }

  scope :persisted, -> { where.not(id: nil) }
end

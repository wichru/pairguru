class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user, :movie, presence: true, uniqueness: { scope: %i[movie user] }
end

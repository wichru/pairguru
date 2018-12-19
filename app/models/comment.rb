class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

<<<<<<< HEAD
<<<<<<< HEAD
  validates :body, presence: true
  validates :user, :movie, presence: true
  validates :user, uniqueness: { scope: :movie }

  scope :persisted, -> { where.not(id: nil) }
=======
  validates :user, :movie, presence: true, uniqueness: { scope: %i[movie user] }
>>>>>>> 8005ca0607cacd99e7edd3ccb2944ec48628d295
=======
  validates :user, :movie, presence: true, uniqueness: { scope: %i[movie user] }
>>>>>>> 8005ca0607cacd99e7edd3ccb2944ec48628d295
end

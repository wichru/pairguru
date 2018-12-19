FactoryBot.define do
  factory :comment do
    body "This is a comment"
    movie
    user
  end
end

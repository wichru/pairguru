FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    confirmed_at 1.day.ago
  end

  factory :unconfirmed_user do
    email { Faker::Internet.email }
    password "password"
  end
end

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com"}
    password { "somepass" }
  end
end

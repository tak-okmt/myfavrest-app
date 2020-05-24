FactoryBot.define do
  factory :user do
    sequence(:user_id) { |n| "taro#{n}" }
    sequence(:email) { |n| "test#{n}@gmail.com" }
    password { "testpassword" }
  end
end
FactoryBot.define do
  factory :post do
    title { "test" }
    description { "test" }
    prefecture_code { "1" }
    rest_type { "1" }

    association :user
    association :community
  end
end

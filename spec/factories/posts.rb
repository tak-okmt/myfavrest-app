FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "テスト投稿#{n}"}
    description {"口コミのテストです"}
    prefecture_code {"1"}
    rest_type {"1"}
    association :user
    association :community
  end
end

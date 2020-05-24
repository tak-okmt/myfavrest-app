FactoryBot.define do
  factory :post do
   sequence(:title) { |n| "テスト投稿#{n}"}
   description {"口コミのテストです"}
   association :user
  end
end

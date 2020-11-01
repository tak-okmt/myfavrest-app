FactoryBot.define do
  factory :community do
    name { "MyString" }
    create_user_id { 1 }
    publish_flg { 1 }

    association :user
  end
end

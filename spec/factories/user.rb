FactoryBot.define do
    factory :user do
        user_id { 'abc' }
        username { 'テストユーザー' }
        email { 'test1@example.com' }
        password { 'password' }
    end
end
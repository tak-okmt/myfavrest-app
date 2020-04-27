FactoryBot.define do
    factory :post do
        title { '投稿No.1' }
        description { 'ますはテストを実施する' }
        user
    end
end
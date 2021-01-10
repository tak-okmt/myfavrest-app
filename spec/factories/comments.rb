FactoryBot.define do
  factory :comment do
    content { "test" }
    score { 5 }
    visitday { "2021/1/1" }

    association :user
    association :post    
  end
end

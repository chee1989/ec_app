FactoryBot.define do
  factory :product do
    title 'test'
    price 2000
    introduction 'test introduction!'
    association :category
    association :user
  end
end

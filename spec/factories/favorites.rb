FactoryBot.define do
  factory :favorite do
    association :product
    association :user
  end
end

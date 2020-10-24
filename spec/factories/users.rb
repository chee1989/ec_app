FactoryBot.define do
  factory :user do
    name 'テスト'
    nick_name 'テストデータ'
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end
end

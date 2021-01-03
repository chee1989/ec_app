FactoryBot.define do
  factory :user do
    name 'テスト'
    nick_name 'テストデータ'
    sequence(:email) { |n| "test#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    # skip confirmation
    confirmed_at Time.now
  end
end

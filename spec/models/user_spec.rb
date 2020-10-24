require 'rails_helper'

RSpec.describe User, type: :model do
  # ユーザ名、ニックネーム、メールアドレス、パスワード、管理者権限があれば有効な状態であること
  it "is valid with a name, nick name, email, password, admin" do
    user = User.new(
      name: 'テスト',
      nick_name: 'テストデータ',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password',
    )
    expect(user).to be_valid
  end
  # ユーザ名がなければ無効な状態であること
  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  # ニックネームがなければ無効な状態であること
  it "is invalid without a nick name" do
    user = User.new(nick_name: nil)
    user.valid?
    expect(user.errors[:nick_name]).to include("を入力してください")
  end
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email adress" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  # 有効なファクトリを持つこと 
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: 'test@example.com')
    user = FactoryBot.build(:user, email: 'test@example.com')
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  # 複数のユーザーで何かする
  it "does something with multiple users" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)
    expect(true).to be_truthy
  end
end

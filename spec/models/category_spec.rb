require 'rails_helper'

RSpec.describe Category, type: :model do
  # カテゴリ名があれば有効な状態であること
  it "is valid with a name" do
    category = Category.new(
      name: 'テスト',
    )
    expect(category).to be_valid
  end
  # カテゴリ名がなければ無効な状態であること
  it "is invalid without a name" do
    category = Category.new(name: nil)
    category.valid?
    expect(category.errors[:name]).to include("を入力してください")
  end
  # 有効なファクトリを持つこと 
  it "has a valid factory" do
    expect(FactoryBot.build(:category)).to be_valid
  end
  # 重複したカテゴリ名なら無効な状態であること
  it "is invalid with a duplicate name" do
    FactoryBot.create(:category, name: 'test')
    category = FactoryBot.build(:category, name: 'test')
    category.valid?
    expect(category.errors[:name]).to include("はすでに存在します")
  end
end

require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
  end
  # 商品名、商品紹介、価格、カテゴリ名、出品者名があれば有効な状態であること
  it "is valid with a title, price, introduction, user_id and category_id" do
    product = Product.new(
      title: 'テスト',
      price: 1000,
      introduction: 'テスト 紹介',
      user_id: @user.id,
      category_id: @category.id,
    )
    expect(product).to be_valid
  end
  # 商品名がなければ無効な状態であること
  it "is invalid without a title" do
    product = Product.new(title: nil)
    product.valid?
    expect(product.errors[:title]).to include("を入力してください")
  end
  # 価格がなければ無効な状態であること
  it "is invalid without a price" do
    product = Product.new(price: nil)
    product.valid?
    expect(product.errors[:price]).to include("を入力してください")
  end
  # 価格が数値なければ無効な状態であること
  it "is invalid without a price not integer" do
    product = Product.new(price: 'test')
    product.valid?
    expect(product.errors[:price]).to include("は数値で入力してください")
  end
  # 価格が1以上でなければ無効な状態であること
  it "is invalid without a price greater than 1" do
    product = Product.new(price: 0)
    product.valid?
    expect(product.errors[:price]).to include("は1より大きい値にしてください")
  end
end

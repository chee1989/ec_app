require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
  end
  # ユーザーID、商品IDがあれば有効であること
  it "is valid with a user_id and product_id" do
    favo = Favorite.new(
      user_id: @user.id,
      product_id: @product.id,
    )
    expect(favo).to be_valid
  end
  # ユーザーIDがなければ無効な状態であること
  it "is invalid without a user_id" do
    favo = Favorite.new(user_id: nil)
    favo.valid?
    expect(favo.errors[:user]).to include("を入力してください")
  end
  # 商品IDがなければ無効な状態であること
  it "is invalid without a product_id" do
    favo = Favorite.new(product_id: nil)
    favo.valid?
    expect(favo.errors[:product]).to include("を入力してください")
  end
  # 重複したいいねは無効な状態であること
  it "is invalid with a duplicate favorites" do
    FactoryBot.create(:favorite, user_id: @user.id, product_id: @product.id)
    favo = FactoryBot.build(:favorite, user_id: @user.id, product_id: @product.id)
    favo.valid?
    expect(favo.errors[:user_id]).to include("はすでに存在します")
  end
end

require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
  end
  # ユーザーID、商品IDがあれば有効であること
  it "is valid with a user_id and product_id" do
    like = Like.new(
      user_id: @user.id,
      product_id: @product.id,
    )
    expect(like).to be_valid
  end
  # ユーザーIDがなければ無効な状態であること
  it "is invalid without a user_id" do
    like = Like.new(user_id: nil)
    like.valid?
    expect(like.errors[:user]).to include("を入力してください")
  end
  # 商品IDがなければ無効な状態であること
  it "is invalid without a product_id" do
    like = Like.new(product_id: nil)
    like.valid?
    expect(like.errors[:product]).to include("を入力してください")
  end
  # 重複したいいねは無効な状態であること
  it "is invalid with a duplicate likes" do
    FactoryBot.create(:like, user_id: @user.id, product_id: @product.id)
    like = FactoryBot.build(:like, user_id: @user.id, product_id: @product.id)
    like.valid?
    expect(like.errors[:user_id]).to include("はすでに存在します")
  end
end

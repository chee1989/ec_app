require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  describe "#create" do
    # 認証済みのユーザーとして
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category)
        @product = FactoryBot.create(:product, user_id: @user.id, category_id: @category.id)
        sign_in @user
      end
      # お気に入りできること
      # it "adds a like" do
      #   expect {
      #           post :create, params: { user_id: @user.id, product_id: @product.id }
      #         }.to change(Favorite, :count).by(1)
      # end
    end
    # ゲストとして
    context "as a guest" do
      before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category)
        @product = FactoryBot.create(:product, user_id: @user.id, category_id: @category.id)
      end
      # 302レスポンスを返すこと
      it "returns a 302 response" do
        post :create, params: { product_id: @product.id }
        expect(response).to have_http_status "302"
      end
      # サインイン画面にリダイレクトすること
      it "redirects to the sign-in page" do
        post :create, params: { product_id: @product.id  }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end

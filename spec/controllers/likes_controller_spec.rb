require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  describe "#create" do
    # 認証済みのユーザーとして
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category)
        @product = FactoryBot.create(:product, user_id: @user.id, category_id: @category.id)
        @like = FactoryBot.create(:like, user_id: @user.id, product_id: @product.id)
        sign_in @user
      end
      # いいねできること
      # it "adds a like" do
      #   expect {
      #     post :create, params: {"product_id"=>@product.id}
      #   }.to change(Like, :count).by(1)
      # end
      # it "deletes a like" do
      #   expect {
      #     binding.pry
      #     delete :destroy, params: { id: @like.id } 
      #   }.to change(Like, :count).by(-1)
      # end
      # JSON 形式でレスポンスを返すこと
      it "responds with JSON formatted output" do
        post :create, format: :json,
        params: { product_id: @product.id, user_id: @user.id } 
        expect(response.content_type).to eq "application/json"
      end
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

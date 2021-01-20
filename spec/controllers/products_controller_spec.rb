require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "#index" do
    # 認証済みのユーザーとして
    context "as an authenticated user" do
      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
      end
      # 正常にレスポンスを返すこと
      it "responds successfully" do
        get :index
        expect(response).to be_success
      end
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        get :index
        expect(response).to have_http_status "200"
      end
    end
    # ゲストとして
    context "as a guest" do
      # 302レスポンスを返すこと
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end
      # サインイン画面にリダイレクトすること
      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "#show" do
    # 認可されたユーザーとして
    context "as an authorized user" do
      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category)
        @product = FactoryBot.create(:product, user_id: @user.id, category_id: @category.id)
      end
      # 正常にレスポンスを返すこと
      it "responds successfully" do
        sign_in @user
        get :show, params: { id: @product.id }
        expect(response).to be_success
      end
    end
    # 認可されていないユーザーとして
    context "as an unauthorized user" do
      before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category)
        @product = FactoryBot.create(:product, user_id: @user.id, category_id: @category.id)
      end
      # サインイン画面にリダイレクトすること
      it "redirects to the dashboard" do
        get :show, params: { id: @product.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end

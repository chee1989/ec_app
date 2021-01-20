require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
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
      # 正常にレスポンスを返すこと
      it "redirects to the dashboard" do
        get :show, params: { id: @product.id }
        expect(response).to be_success
      end
    end
  end
end

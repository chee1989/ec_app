require 'rails_helper'

RSpec.feature "Products", type: :feature do
  # ユーザーはログインすると一覧画面から商品詳細画面を閲覧できる
  scenario "user creates a like" do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)

    visit root_path
    visit "/products/#{product.id}"
    expect(page).to have_content "アカウント登録もしくはログインしてください"
    login(user)
    expect(page).to have_content 'ログインしました。'
    visit root_path
    expect(page).to have_content "商品詳細"
    click_link "商品詳細"
    # visit "/products/#{product.id}"
    expect(page).to have_content "お気に入りする"
  end
end

require 'rails_helper'

RSpec.feature "Products", type: :feature do
  # ユーザーはログインすると一覧画面から商品詳細画面を閲覧できる
  scenario "user creates a like" do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)

    visit root_path
    visit "/products/#{product.id}"
    expect(page).to have_content "アカウント登録もしくはログインしてください"
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    find(".btn.btn-lg.btn-primary.my-3").click
    visit root_path
    # visit "/products/#{product.id}"
    expect(page).to have_content "商品詳細"
    # click_link "商品詳細"
    # expect(page).to have_content "お気に入りする"
  end
end

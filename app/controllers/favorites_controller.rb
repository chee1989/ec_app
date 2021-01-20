class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favorite = current_user.favorites.build(product_id: params[:product_id])
    favorite.save!
    redirect_to favorites_users_path, notice: "お気に入り登録しました。"
  end

  def destroy
    product = Product.find(params[:id])
    current_user.favorites.find_by(product_id: product.id).destroy!
    redirect_to favorites_users_path, notice: "お気に入りから外しました。"
  end
end

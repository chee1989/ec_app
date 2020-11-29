class UsersController < ApplicationController
  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def favorites
    @user = current_user
    @products = @user.products
    favorites = Favorite.where(user_id: current_user.id).pluck(:product_id)
    @favorite_list = Product.find(favorites)
  end
end

class HomesController < ApplicationController
  def index
    @products = Product.with_attached_images.includes(:user, :category, :likes)
    @categories = Category.includes(:products)
    @samples = @products.sample(6)
    @new_products = @products.order(created_at: :desc).first(6)
  end

  def favorites
    @products = current_user.favorite_products.includes(:user)
  end
end

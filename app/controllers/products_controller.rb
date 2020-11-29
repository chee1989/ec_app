class ProductsController < ApplicationController
  def index
    @products = Product.all.includes(:user)
  end

  def show
    @product = Product.find(params[:id])
  end

  def favorites
    @products = current_user.favorite_products.includes(:user)
  end
end

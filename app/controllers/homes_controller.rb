class HomesController < ApplicationController
  def index
    @products = Product.all
    @categories = Category.all
    @samples = @products.sample(6)
    @new_products = @products.order(created_at: :desc).first(6)
  end
end

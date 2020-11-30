class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.likes.create(product_id: params[:product_id])
    redirect_to product_path(params[:product_id])
  end

  def destroy
    @product = Product.find(params[:id])
    @like = Like.find_by(product_id: @product.id, user_id: current_user.id)
    @like.destroy
    redirect_to product_path(@product)
  end
end

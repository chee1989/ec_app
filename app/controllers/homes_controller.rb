class HomesController < ApplicationController
  def index
    @products = Product.with_attached_images.includes(:user, :category, :likes)
    @categories = Category.includes(:products)
    @samples = @products.where('title LIKE ?', "%テスト%").page(params[:page]).per(3)
    @new_products = @products.order(created_at: :desc).page(params[:page]).per(3)
    @like_products = Product.with_attached_images.includes(:user, :category).like_sort_desc.page(params[:page]).per(3)

    return unless request.xhr?
    case params[:type]
    when 'sample', 'new_pro', 'like_pro'
      render "#{params[:type]}"
    end
  end

  def favorites
    @products = current_user.favorite_products.includes(:user)
  end
end

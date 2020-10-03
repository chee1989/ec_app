class Admin::ProductsController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin

  def index
    sort = params[:sort] || 'created_at desc'
    @search_params = product_search_params
    @products = Product.order(sort).search(@search_params).includes(:category).page(params[:page])

    respond_to do |format|
      format.html
      format.csv {send_data render_to_string, filename: "products-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def confirm_new
    @product = current_user.products.new(product_params)
    render :new unless @product.valid?
  end

  def create
    @product = Product.new(product_params)

    if params[:back].present?
      render :new
      return
    end

    if @product.save
      redirect_to admin_products_path, notice: "商品「#{@product.title}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "商品「#{@product.title}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_url, notice: "商品「#{@product.title}」を削除しました。"
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :introduction, :user_id, :category_id, images: [])
  end

  def product_search_params
    params.fetch(:search, {}).permit(:title, :min_price, :max_price, :category_id, :user_id)
  end
end

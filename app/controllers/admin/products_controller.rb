class Admin::ProductsController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin

  def index
    @products = Product.order(created_at: :desc)
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

  private

  def product_params
    params.require(:product).permit(:title, :price, :introduction, :user_id, :category_id)
  end
end

class Admin::CategoriesController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin

  def index
    sort = params[:sort] || 'created_at desc'
    @search_params = category_search_params
    @categories = Category.order(sort).search(@search_params).page(params[:page])
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "カテゴリ「#{@category.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: "カテゴリ「#{@category.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_url, notice: "カテゴリ「#{@category.name}」を削除しました。"
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def category_search_params
    params.fetch(:search, {}).permit(:name)
  end
end

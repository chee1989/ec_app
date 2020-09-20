class Admin::UsersController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin

  def index
    @search_params = user_search_params
    @users = User.order(params[:sort]).search(@search_params).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_root_path, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :nick_name, :email, :admin, :password, :password_confirmation)
  end

  def user_search_params
    params.fetch(:search, {}).permit(:name, :nick_name, :email, :admin, :created_at_from, :created_at_to)
  end
end

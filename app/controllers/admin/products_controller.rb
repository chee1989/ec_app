class Admin::ProductsController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin

  def index
    @products = Product.order(created_at: :desc)
  end
end

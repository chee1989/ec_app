class Admin::LogsController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin

  def index
    @search_params = log_search_params
    @logs = Log.order(params[:sort]).search(@search_params).includes(:user).page(params[:page])
  end

  private

  def log_search_params
    params.fetch(:search, {}).permit(:record_type, :created_at_from, :created_at_to)
  end
end

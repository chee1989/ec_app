class Admin::LogsController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin

  def index
    @logs = Log.order(created_at: :desc)
  end
end

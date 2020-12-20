class Admin::HomesController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin
  layout 'admin/admin_front'

  def index
  end
end

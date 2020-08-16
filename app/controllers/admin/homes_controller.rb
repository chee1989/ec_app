class Admin::HomesController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin

  def index
  end
end

class Admin::HomesController < ApplicationController
  include Admin::UserHelper
  before_action :correct_user

  def index
  end
end

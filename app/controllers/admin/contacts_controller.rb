class Admin::ContactsController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin
  layout 'admin/admin_front'

  def index
    @contacts = Contact.order(created_at: :desc).page(params[:page])
  end
end

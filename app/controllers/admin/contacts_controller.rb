class Admin::ContactsController < ApplicationController
  include Admin::UserHelper
  before_action :only_admin

  def index
    @contacts = Contact.order(created_at: :desc)
  end
end

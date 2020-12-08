class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      redirect_to root_path, notice: '送信しました。'
    else
      redirect_to root_path, alert: '送信できませんでした。'
    end
  end

  private

  def contact_params
    params.permit(:user_id, :title, :content)
  end
end

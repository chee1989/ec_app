module Admin::UserHelper
  def only_admin
    unless authenticate_user! && current_user.admin?
      redirect_to root_url
      flash[:alert] = '権限がありません。'
    end
  end
end
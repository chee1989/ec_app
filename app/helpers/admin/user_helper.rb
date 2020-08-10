module Admin::UserHelper
  def correct_user
    unless authenticate_user! && current_user.admin?
      redirect_to root_url
      flash[:alert] = '権限がありません。'
    end
  end
end
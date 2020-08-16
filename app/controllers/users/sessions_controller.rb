# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    Log.create!(user_id: current_user.id, record_type: 'ログイン')
  end

  # DELETE /resource/sign_out
  def destroy
    user = current_user
    super
    Log.create!(user_id: user.id, record_type: 'ログアウト') if user.present?
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

class Log < ApplicationRecord
  # 関連
  belongs_to :user, dependent: :destroy

  # 委譲
  def user_name; user.name end
  def user_email; user.email end
end

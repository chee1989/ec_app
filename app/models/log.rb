class Log < ApplicationRecord
  # 関連
  belongs_to :user, dependent: :destroy

  # 委譲
  def user_name; user.name end
  def user_email; user.email end
  
  # スコープ
  scope :search, -> (search_params) do
    return if search_params.blank?
    record_type_like(search_params[:record_type])
    .created_at_from(search_params[:created_at_from])
    .created_at_to(search_params[:created_at_to])
  end
  scope :record_type_like, -> (record_type) { where(record_type: record_type) if record_type.present? }
  scope :created_at_from, -> (from) { where('created_at >= ?', from) if from.present? }
  scope :created_at_to, -> (to) { where('created_at <= ?', to) if to.present? }
end

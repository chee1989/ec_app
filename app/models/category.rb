class Category < ApplicationRecord
  # バリデーション
  validates :name,     presence: true,
                       uniqueness: true

  # 関連
  has_many :products

  # スコープ
  scope :search, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:name])
  end
  scope :name_like, -> (name) { where(name: name) if name.present? }
end

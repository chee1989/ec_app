class Like < ApplicationRecord
  # バリデーション
  validates :user_id, uniqueness: { scope: :product_id }

  # 関連
  belongs_to :user
  belongs_to :product
end

class Category < ApplicationRecord
  # バリデーション
  validates :name,     presence: true,
                       uniqueness: true

  # 関連
  has_many :products
end

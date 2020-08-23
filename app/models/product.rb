class Product < ApplicationRecord
  # バリデーション
  validates :title,  presence: true
  validates :price,  presence: true,
                     numericality: { only_integer: true,
                                     greater_than: 1
                    }

  # 関連
  belongs_to :user
  belongs_to :category
  has_many_attached :images

  # 委譲
  def user_name; user.name end
  def category_name; category.name end
end

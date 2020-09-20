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

  # スコープ
  scope :search, -> (search_params) do
    return if search_params.blank?
    title_like(search_params[:title])
    .category_id_is(search_params[:category_id])
    .user_id_is(search_params[:user_id])
    .min_price(search_params[:min_price])
    .max_price(search_params[:max_price])
  end
  scope :title_like, -> (title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :category_id_is, -> (category_id) { where(category_id: category_id) if category_id.present? }
  scope :user_id_is, -> (user_id) { where(user_id: user_id) if user_id.present? }
  scope :min_price, -> (min) { where('price >= ?', min) if min.present? }
  scope :max_price, -> (max) { where('price <= ?', max) if max.present? }

  # クラスメソッド
  def self.csv_attributes
    ['category_name', 'title', 'price', 'user_name', 'created_at', 'updated_at']
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |product|
        csv << csv_attributes.map {|attr| product.send(attr)}
      end
    end
  end
end

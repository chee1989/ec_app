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
  has_many :favorites, dependent: :destroy
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

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
  scope :like_sort_desc, -> { joins(:likes).group(:product_id).order(Arel.sql('count(likes.id) desc')) }

  # クラスメソッド
  def self.csv_format_check(file)
    errors = []
    CSV.foreach(file.path, headers: true).with_index(1) do |row, index|
      user = User.find_by(name: row["出品者名"])
      category = Category.find_by(name: row["カテゴリ名"])
      errors << "#{index}行目 出品者名が不正です" if user.blank? # 出品者名が不正
      errors << "#{index}行目 カテゴリ名が不正です" if category.blank? # カテゴリ名が不正

      if row["ID"].present?
        product = find_by(id: row["ID"])
        errors << "#{index}行目 IDが不正です" if product.blank? # IDが不正
      else
        u_id = user.id if user.present?
        c_id = category.id if category.present?
        product = new(title: row["商品名"], price: row["値段"], user_id: u_id, category_id: c_id)
        errors << "#{index}行目 新規作成できませんでした" if product.invalid? # 新規作成データが不正
      end
    end
    errors
  end

  def self.import_save(file)
    new_count = 0
    update_count = 0
    nochange_count = 0
    CSV.foreach(file.path, headers: true) do |row|
      user = User.find_by(name: row["出品者名"])
      category = Category.find_by(name: row["カテゴリ名"])

      if row["ID"].present?
        product = find(row["ID"])
        product.assign_attributes(id: row["ID"], title: row["商品名"], price: row["値段"], user_id: user.id, category_id: category.id)
        if product.changed?
          product.save!
          update_count += 1
        else
          nochange_count += 1
        end
      else
        product = new(id: row["ID"], title: row["商品名"], price: row["値段"], user_id: user.id, category_id: category.id)
        product.save!
        new_count += 1
      end
    end
    "新規作成：#{new_count}件、更新：#{update_count}件、無変更：#{nochange_count}件"
  end

  # メソッド
  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end

class User < ApplicationRecord
  # バリデーション
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true

  # デバイス
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # 関連
  has_many :logs
  has_many :contacts
  has_many :products
end

class User < ApplicationRecord
  # バリデーション
  validates :name,  presence: true
  validates :nick_name,  presence: true
  validates :email, presence: true, uniqueness: true

  # デバイス
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # 関連
  has_many :logs
  has_many :contacts
  has_many :products

  # スコープ
  scope :search, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:name])
    .nick_name_like(search_params[:nick_name])
    .email_like(search_params[:email])
    .admin_is(search_params[:admin])
    .created_at_from(search_params[:created_at_from])
    .created_at_to(search_params[:created_at_to])
  end
  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :nick_name_like, -> (nick_name) { where('nick_name LIKE ?', "%#{nick_name}%") if nick_name.present? }
  scope :email_like, -> (email) { where('email LIKE ?', "%#{email}%") if email.present? }
  scope :admin_is, -> (admin) { where(admin: admin) if admin.present? }
  scope :created_at_from, -> (from) { where('created_at >= ?', from) if from.present? }
  scope :created_at_to, -> (to) { where('created_at <= ?', to) if to.present? }
end

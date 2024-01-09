class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  has_many :items
  has_many :cart_items
  has_many :addresses
  has_many :orders
  has_many :customer_rooms
  has_many :chats
  has_many :rooms, through: :customer_rooms
  has_many :active_notices, class_name: 'Notice', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'visited_id', dependent: :destroy
  has_one_attached :customer_image

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :post_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
  
  # chat機能
  has_many :selling_items, class_name: 'Item', foreign_key: 'customer_id'
  has_many :purchased_items, class_name: 'Item', foreign_key: 'buyer_id'

  def get_customer_image(width, height)
    unless customer_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      customer_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    # item_image.variant(resize_to_limit: [width, height]).processed
    #上のコードだと元ん画像のサイズより大きくできない
    customer_image.variant(resize: "#{width}x#{height}!").processed
  end
  
  def full_name
    last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

  def guest?
    email == 'guest@example.com'
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.password_confirmation = customer.password
      customer.last_name = "顧客"
      customer.first_name = "仮"
      # 他の必要な属性に適当な値を設定
      customer.last_name_kana = "ゲスト"
      customer.first_name_kana = "ユーザー"
      customer.post_code = "1234567" # ダミーの郵便番号
      customer.address = "東京都ゲスト市ゲスト区1-1-1" # ダミーの住所
      customer.phone_number = "09012345678" # ダミーの電話番号
      customer.is_active = true
    end
  end
  
end

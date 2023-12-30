class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :cart_items
  has_many :addresses
  has_many :orders
  has_many :customer_rooms
  has_many :chats
  has_many :rooms, through: :customer_rooms
  has_one_attached :customer_image

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :post_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
  
  
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

  def has_in_cart(item)
    cart_items.find_by(item_id: item.id)
  end
end

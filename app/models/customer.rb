class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :cart_items
  has_many :addresses

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :email, presence: true, uniqueness: true
  validates :post_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }

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

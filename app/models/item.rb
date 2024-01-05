class Item < ApplicationRecord

  acts_as_taggable_on :tags

  belongs_to :customer
  has_one :order
  # has_many :notices, dependent: :destory
  has_one_attached :item_image
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  # chat機能
  has_one :customer_room
  belongs_to :seller, class_name: 'Customer', foreign_key: 'customer_id'
  belongs_to :buyer, class_name: 'Customer', foreign_key: 'buyer_id', optional: true
  
  
  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    # item_image.variant(resize_to_limit: [width, height]).processed
    #上のコードだと元ん画像のサイズより大きくできない
    item_image.variant(resize: "#{width}x#{height}!").processed
  end

  def with_tax_price
    (price * 1.1).ceil
    # ceilは切り上げ、floorが切り捨て、roundが四捨五入
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "is_active", "name", "price"]
  end


end

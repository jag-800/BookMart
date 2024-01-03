class Room < ApplicationRecord
  
  has_many :customer_rooms
  has_many :chats
  has_many :customers, through: :customer_rooms
  has_one :item, through: :customer_rooms
  
  # 関連するItemを見つけるメソッド
  def related_item
    customer_rooms.first&.item
  end
  
end

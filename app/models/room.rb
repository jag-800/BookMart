class Room < ApplicationRecord
  
  has_many :customer_rooms
  has_many :chats
  has_many :customers, through: :customer_rooms
  
  # 現在の顧客以外の顧客を返すメソッド
  def other_customer(current_customer)
    customers.where.not(id: current_customer.id).first
  end
  
end

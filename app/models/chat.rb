class Chat < ApplicationRecord
  
  belongs_to :customer
  belongs_to :room
  
  validates :message, length: { in: 1..140 }
  
end

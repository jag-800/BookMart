class ItemComment < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item
  
  validates :comment, length: { in: 1..140 }
end

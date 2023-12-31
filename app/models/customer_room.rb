class CustomerRoom < ApplicationRecord
  
  belongs_to :customer
  belongs_to :room
  belongs_to :item
end

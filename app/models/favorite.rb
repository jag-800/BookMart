class Favorite < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item, counter_cache: true
  validates :customer_id, uniqueness: {scope: :item_id}
  
  def self.ransackable_attributes(auth_object = nil)
    super + ['favorites_count']
  end

end

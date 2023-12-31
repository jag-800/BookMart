class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  enum status: { duaring_trading: 0, traded: 1, suspended_trading: 2 }
  
  after_create :deactivate_item, :create_customer_room

  private

  def deactivate_item
    item.update(is_active: false, buyer_id: customer_id) if item.present?
  end

  def create_customer_room
    return if item.nil?

    existing_room = CustomerRoom.find_by(item_id: item.id)
    return if existing_room.present?

    room = Room.create
    CustomerRoom.create(customer_id: item.customer_id, item_id: item.id, room_id: room.id)
  end
  
end

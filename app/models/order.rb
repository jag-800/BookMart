class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  has_many :notices, dependent: :destroy

  enum status: { duaring_trading: 0, traded: 1, suspended_trading: 2 }
  
  after_create :deactivate_item, :create_customer_room
  

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
  
  def create_order_notification(order)
    # 購入者に通知（購入者は `order.customer`）
    Notice.create!(
      order_id: order.id,
      visited_id: order.customer.id, # 購入者のID
      visitor_id: order.item.customer.id, # 出品者のID
      action: 'order'
    )

    # 出品者に通知（出品者は `order.item.customer`）
    Notice.create!(
      order_id: order.id,
      visited_id: order.item.customer.id, # 出品者のID
      visitor_id: order.customer.id, # 購入者のID
      action: 'order'
    )
  end
  
  def create_order_status_update_notification(order)
    # 注文ステータスが更新されたことを購入者に通知
    Notice.create!(
      order_id: order.id,
      visited_id: order.customer.id, # 購入者のID
      visitor_id: order.item.customer.id, # 出品者のID
      action: 'order_status_update'
    )
  
    # 注文ステータスが更新されたことを出品者に通知
    Notice.create!(
      order_id: order.id,
      visited_id: order.item.customer.id, # 出品者のID
      visitor_id: order.customer.id, # 購入者のID
      action: 'order_status_update'
    )
  end
  
end

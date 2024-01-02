class Chat < ApplicationRecord

  belongs_to :customer
  belongs_to :room
  has_many :notices, dependent: :destroy

  validates :message, length: { in: 1..140 }

  def create_notification_chat!(current_customer, chat_id, visited_id)
    # チャットの受信者に通知を送る
    save_notification_chat!(current_customer, chat_id, visited_id)
  end

  def save_notification_chat!(current_customer, chat_id, visited_id)
    # チャット通知を作成
    notification = current_customer.active_notifications.new(
      chat_id: chat_id,
      visited_id: visited_id,
      action: 'chat'
    )
    # 自分自身へのチャットの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end


end

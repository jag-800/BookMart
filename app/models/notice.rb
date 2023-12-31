class Notice < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }
  belongs_to :item, optional: true
  belongs_to :chat, optional: true
  belongs_to :order, optional: true
  belongs_to :admin, optional: true
  
  # 通知の送信者 (訪問者) - Customer モデルに関連付ける
  belongs_to :visitor, class_name: 'Customer', foreign_key: 'visitor_id', optional: true
  # 通知の受信者 - Customer モデルに関連付ける
  belongs_to :visited, class_name: 'Customer', foreign_key: 'visited_id', optional: true
  
end

class Notice < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }
  belongs_to :item, optional: true
  belongs_to :chat, optional: true
  
  belongs_to :visitor, class_name: 'Notice', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'Notice', foreign_key: 'visited_id', optional: true
end

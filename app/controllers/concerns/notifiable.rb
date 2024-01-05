# 通知作成メソッドの例
module Notifiable
  extend ActiveSupport::Concern
  
  def create_admin_notification(visitor, admin, action, notifiable = nil)
    notice_params = {
      visitor_id: visitor.id,
      admin_id: admin.id,
      action: action
    }
    
    # notifiableオブジェクトに基づいて適切な属性を設定
    if notifiable.is_a?(Item)
      notice_params[:item_id] = notifiable.id
    elsif notifiable.is_a?(Order)
      notice_params[:order_id] = notifiable.id
    end
  
    Notice.create(notice_params)
  end
end
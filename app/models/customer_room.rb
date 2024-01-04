class CustomerRoom < ApplicationRecord
  
  belongs_to :customer
  belongs_to :room
  belongs_to :item
  
   # 現在の顧客以外の顧客を返すメソッド
  def other_customer(current_customer)
    # 購入者が現在の顧客であるかどうかを確認
    if item.buyer_id == current_customer.id
      # 購入者が現在の顧客の場合、商品の出品者を返す
      Customer.find(item.customer_id)
    else
      # そうでない場合、購入者を返す（購入者が存在する場合）
      Customer.find(item.buyer_id) if item.buyer_id
    end
  end
  
end

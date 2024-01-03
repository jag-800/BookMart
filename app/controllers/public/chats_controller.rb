class Public::ChatsController < ApplicationController
  before_action :set_chat_room, only: [:show]

  def show
    if @chat_room.item.seller != current_customer && @chat_room.item.buyer != current_customer
      redirect_to root_path
    end
    @customer = @chat_room.customer #相手のid 14行目で使う
    rooms = @chat_room.item.seller.customer_rooms.pluck(:room_id)
    customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)

    @room = customer_rooms.room
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
    @my_name = "自分"

    @item = @chat_room.item
  end
  
  def create
    @chat = current_customer.chats.new(chat_params)
    @room = @chat.room
    @chats = @room.chats
  
    if @chat.save
      # 関連する CustomerRoom を取得
      customer_room = CustomerRoom.find_by(room_id: @room.id)
      # チャットの受信者（other_customer）を特定
      if customer_room
        other_customer_id = @room.customer_rooms.where.not(customer_id: current_customer.id).pluck(:customer_id).first
        if other_customer_id
          # 通知を作成
          save_notification_chat!(current_customer, @chat.id, other_customer_id)
        else
          Rails.logger.error("Other customer not found in Room ID: #{@room.id}")
        end
      else
        Rails.logger.error("CustomerRoom not found for Room ID: #{@room.id}")
      end
    else
      # チャットの保存に失敗した場合の処理
      render :validater
    end
  end

  def destroy

    @chat = Chat.find(params[:id])
    @room = @chat.room
    @chats = @room.chats

    if @chat.customer_id == current_customer.id
      @chat.destroy
    end
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def set_chat_room
    @chat_room = CustomerRoom.find(params[:id])
  end
  
  def save_notification_chat!(current_customer, chat_id, other_customer_id)
    # チャット通知を作成
    notification = current_customer.active_notices.new(
      chat_id: chat_id,
      visitor_id: current_customer.id,
      visited_id: other_customer_id,
      action: 'chat'
    )
  
    # 自分自身へのチャットの場合は、通知済みとする
    notification.checked = true if current_customer.id == other_customer_id
  
    # 通知の保存
    if notification.valid?
      notification.save
    else
      # バリデーションエラーがある場合は、ログに記録する
      Rails.logger.error("Failed to save notification: #{notification.errors.full_messages.join(", ")}")
    end
  end
end

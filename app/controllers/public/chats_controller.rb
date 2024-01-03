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
      # 関連するItemのIDを取得
      related_item = @room.related_item
  
      if related_item
        # 関連する CustomerRoom を取得
        customer_room = CustomerRoom.find_by(room: @room, item_id: related_item.id)
        other_customer = customer_room.other_customer(current_customer) if customer_room
  
        if other_customer
          # 通知を作成
          @chat.create_notification_chat!(current_customer, @chat.id, other_customer.id)
        else
          # 他の顧客が見つからない場合のエラーログ
          Rails.logger.error("Other customer not found in Room ID: #{@room.id}")
        end
      else
        # 関連するItemが見つからない場合のエラーログ
        Rails.logger.error("Item not found for Room ID: #{@room.id}")
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
end

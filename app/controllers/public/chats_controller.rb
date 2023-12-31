class Public::ChatsController < ApplicationController
  before_action :set_chat_room, only: [:show]

  def show
    if @chat_room.item.seller != current_customer && @chat_room.item.buyer != current_customer
      redirect_to root_path
    end
    @customer = Customer.find(params[:id]) #相手のid 14行目で使う
    rooms = current_customer.customer_rooms.pluck(:room_id)
    customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)

    unless customer_rooms.nil? #roomがある時
      @room = customer_rooms.room
    else
      @room = Room.new
      @room.save
      CustomerRoom.create(customer_id: current_customer.id, room_id: @room.id)
      CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
    @my_name = "自分"
  end

  def create
    @chat = current_customer.chats.new(chat_params)
    @room = @chat.room
    @chats = @room.chats
    render :validater unless @chat.save
  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
  def set_chat_room
    @chat_room = CustomerRoom.find(params[:id])
  end
end

class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  # before_action :ensure_cart_items, only: [:new, :confirm, :create]

  def new
    @order = Order.new
  end

  def confirm
    @item = Item.find(params[:order][:item_id]) # フォームから送信されたitem_idを使用してItemを取得
    @order = Order.new(item: @item) # 新しいOrderオブジェクトを初期化し、関連するItemを設定
  end

  def create
    @order = current_customer.orders.new(order_params)
    if @order.save
      item = @order.item # または適切な方法でItemオブジェクトを取得
      item.update(is_active: false) # 商品のis_activeをfalseに更新
      item.update(buyer_id: current_customer.id)
      
      # CustomerRoom を作成
      create_customer_room_for_order(@order)
    
      redirect_to thanks_path
    else
      flash[:error] = @order.errors.full_messages
      # render :new
    end
  end

  def thanks
    latest_order = current_customer.orders.order(created_at: :desc).first

    if latest_order
      item = latest_order.item
      if item
        # 商品がある場合、その商品に関連する customer_room を取得
        @customer_room = item.customer_room
      end
    end
    # @customer_room = current_customer.customer_rooms.order(created_at: :desc).first
  end

  def index
    @orders = current_customer.orders.includes(:order_details, :items).page(params[:page]).reverse_order
  end

  def show
    @order = current_customer.orders.find_by(id: params[:id])
    # confirmでリロードした際の処理
    unless @order
      flash[:alert] = "注文に失敗しました。再度操作を行ってください。"
      redirect_to request.referer and return
    end
    @order_details = @order.order_details.includes(:item)
  end

  private

  def order_params
    params.require(:order).permit(:item_id,:name)
  end

  
  def create_customer_room_for_order(order)
    return if order.nil? || order.item.nil?
  
    existing_room = CustomerRoom.find_by(item_id: order.item.id)
  
    if existing_room.nil?
      # 新しい Room インスタンスを作成
      room = Room.new
      if room.save
        # Room が正常に保存された場合、CustomerRoom を作成
        customer_room = CustomerRoom.create!(
          customer_id: order.item.customer_id,
          item_id: order.item.id,
          room_id: room.id
        )
      end
    end
  end
end

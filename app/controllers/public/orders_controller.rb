class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  include Notifiable
  
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
      @order.create_order_notification(@order)
      admin = Admin.find(1)
      create_admin_notification(current_customer, admin, 'order', @order)
      redirect_to thanks_path
    else
      flash[:error] = @order.errors.full_messages
      render :new
    end
  end

  def thanks
    latest_order = current_customer.orders.order(created_at: :desc).first
    if latest_order
      @item = latest_order.item
      if @item
        # 商品がある場合、その商品に関連する customer_room を取得
        @customer_room = @item.customer_room
        @customer = @item.customer
      end
    end
  end

  def index
    @orders = current_customer.orders.includes(:item).page(params[:page]).reverse_order
  end
  
  def buyer
    # 現在のユーザーが出品者である注文を取得
    @orders = Order.joins(:item).where(items: { customer_id: current_customer.id }).includes(:item).page(params[:page]).reverse_order
  end

  def show
    @order = current_customer.orders.find_by(id: params[:id])
    # confirmでリロードした際の処理
    unless @order
      flash[:alert] = "注文に失敗しました。再度操作を行ってください。"
      redirect_to request.referer and return
    end
    @item = @order.item # OrderDetailsがないので、直接Itemを取得
  end

  def details
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_detail_params)
      # 注文ステータスが更新された場合、通知を作成
      create_order_status_update_notification(@order)
      flash[:alert] = "取引ステータスが変更されました。"
      redirect_to request.referer
    else
      # 更新が失敗した場合、エディットフォームを再表示
      render :show, alert: '注文状態の更新に失敗しました。'
    end
  end

  private

  def order_params
    params.require(:order).permit(:item_id, :name, :status)
  end
  
  def order_detail_params
    params.require(:order).permit(:status)
  end

end

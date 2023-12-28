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
      redirect_to thanks_path
    else
      flash[:error] = @order.errors.full_messages
      # render :new
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.includes(:order_details, :items).page(params[:page]).reverse_order
  end

  def show
    @order = current_customer.orders.find_by(id: params[:id])
    # confirmでリロードした際の処理
    unless @order
      flash[:alert] = "注文に失敗しました。再度操作を行ってください。"
      redirect_to cart_items_path and return
    end
    @order_details = @order.order_details.includes(:item)
  end

  private

  def order_params
    params.require(:order).permit(:item_id,:name)
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item, :name)
    redirect_to items_path unless @cart_items.first
  end
end

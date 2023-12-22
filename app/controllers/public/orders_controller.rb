class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_cart_items, only: [:new, :confirm, :create]

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:address_option] == '0'
      @order.get_shipping_informations_from(current_customer)
    elsif params[:address_option] == '1'
      @selected_address = current_customer.addresses.find_by(id: params[:order][:address_id])
      @order.get_shipping_informations_from(@selected_address)
    elsif params[:address_option] == '2' && @order.post_code.present? && (@order.post_code =~ /\A\d{7}\z/) && @order.address.present? && @order.name.present?
      # 処理なし
    else
      flash.now[:notice] = '情報を正しく入力して下さい。'
      render :new
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.total_payment = @order.shipping_cost + @cart_items.sum(&:subtotal)
    if @order.save
      @order.create_order_details(current_customer)
      redirect_to thanks_path
    else
      render :new
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
    params.require(:order).permit(:post_code, :address, :name, :payment_method)
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item)
    redirect_to items_path unless @cart_items.first
  end
end

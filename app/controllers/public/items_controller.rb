class Public::ItemsController < ApplicationController
  before_action :authenticate, only: [:new, :create]
  before_action :ensure_item, only: [:show, :edit, :update]
  include Notifiable

  def index
    @q = Item.ransack(params[:q])
    @items = @q.result.includes(:tags, item_image_attachment: :blob).order(created_at: :desc)
  
    if params[:tag_name]
      @items = @items.tagged_with(params[:tag_name])
    end
  
    @items = @items.page(params[:page])
  end



  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    if @item.save
      admin = Admin.find(1) # 特定の管理者を取得
      create_admin_notification(current_customer, admin, 'item', @item)
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def show
    @order = Order.new
    @item_comment = ItemComment.new
  end

  def edit
  end

  def tag
    @items = Item.all
    @tags = @items.flat_map(&:tag_list).uniq
    @tag_counts = Item.joins(:tags).group('tags.name').count
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to show_information_path(current_customer)
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :item_image, :price, :is_active, :tag_list)
  end

  def ensure_item
    @item = Item.find(params[:id])
  end

  def authenticate
    unless customer_signed_in?
      redirect_to request.referer, alert: "ログイン前にこの操作を実行できません。"
    end
  end
end

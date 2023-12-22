class Public::ItemsController < ApplicationController
  before_action :ensure_item, only: [:show, :edit, :update]

  def index
    @items = Item.page(params[:page])
  end

  def myitem
    @items = current_customer.items
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def show
    @cart_item = CartItem.new
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :item_image, :price, :is_active, :tag_list)
  end

  def ensure_item
    @item = Item.find(params[:id])
  end
end

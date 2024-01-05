class Public::ItemsController < ApplicationController
  before_action :ensure_item, only: [:show, :edit, :update]

  def index
    @q = Item.ransack(params[:q])
    @items = Item.page(params[:page])
    if params[:tag_name]
      @items = Item.tagged_with("#{params[:tag_name]}").page(params[:page])
    end
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
      render :show
    end
  end

  def show
    @order = Order.new
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
end

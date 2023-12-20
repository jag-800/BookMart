class Public::ItemsController < ApplicationController
  before_action :ensure_item, only: [:show, :edit, :update]

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def show
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
    params.require(:item).permit(:name, :introduction, :item_image, :price, :is_active)
  end

  def ensure_item
    @item = Item.find(params[:id])
  end
end

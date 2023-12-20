class Public::ItemsController < ApplicationController
  
  def edit
  end

  def index
    @items = Item.page(params[:page])
  end

  def new
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :item_image, :price, :is_active)
  end

  def ensure_item
    @item = Item.find(params[:id])
  end
end

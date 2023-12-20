class Public::ItemsController < ApplicationController
  before_action :ensure_item, only: [:show, :edit, :update]

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def show
  end
  
  def edit
  end
  
  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :item_image, :price, :is_active)
  end

  def ensure_item
    @item = Item.find(params[:id])
  end
end

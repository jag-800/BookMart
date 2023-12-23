class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_item, only: [:show, :edit, :update]


  def index
    @items = Item.page(params[:page])
    @all_items_count = @items.count
  end

  def show
  end
  
  def tag
    @items = Item.page(params[:page])
    @tags = @items.flat_map(&:tag_list).uniq
    @tag_counts = Item.joins(:tags).group('tags.name').count
  end

  private


  def ensure_item
    @item = Item.find(params[:id])
  end
end

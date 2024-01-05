class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_item, only: [:show, :edit, :update]


  def index
    @q = Item.ransack(params[:q])
    @items = @q.result.page(params[:page])
    @all_items_count = @items.count
    if params[:tag_name]
      @items = Item.tagged_with("#{params[:tag_name]}").page(params[:page])
    end
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

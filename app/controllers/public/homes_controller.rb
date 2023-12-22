class Public::HomesController < ApplicationController
  def top
    @items = Item.page(params[:page])
    @tags = @items.flat_map(&:tag_list).uniq
    @tag_counts = Item.joins(:tags).group('tags.name').count
  end

  def about
  end
end

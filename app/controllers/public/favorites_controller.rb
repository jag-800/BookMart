class Public::FavoritesController < ApplicationController

  def create
    if !Favorite.exists?(item_id: params[:item_id], customer_id: current_customer.id)
      @item = Item.find(params[:item_id])
      @favorite = current_customer.favorites.new(item_id: @item.id)
      @favorite.save
      render 'replace_btn'
    end
  end

  def destroy
    if Favorite.exists?(item_id: params[:item_id], customer_id: current_customer.id)
      @item = Item.find(params[:item_id])
      @favorite = current_customer.favorites.find_by(item_id: @item.id)
      @favorite.destroy
      render 'replace_btn'
    end
  end

end
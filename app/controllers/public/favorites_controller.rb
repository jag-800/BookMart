class Public::FavoritesController < ApplicationController
  before_action :authenticate

  def index
    @favorites = Favorite.where(customer_id: current_customer.id).page(params[:page])
  end

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

  private

  def authenticate
    unless customer_signed_in?
      redirect_to request.referer, alert: "ログイン前にこの操作を実行できません。"
    end
  end
end
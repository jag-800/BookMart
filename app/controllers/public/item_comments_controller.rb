class Public::ItemCommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = current_customer.item_comments.new(item_comment_params)
    @comment.item_id = @item.id
    @comment.save
    # redirect_to item_path(item.id)
    # render 'create'
  end

  def destroy
    @item = Item.find(params[:item_id])
    @comment = ItemComment.find_by(id: params[:id], item_id: params[:item_id])
    @comment.destroy
    # redirect_to item_path(item.id)
    # render 'destroy'
  end

  private
  def item_comment_params
    params.require(:item_comment).permit(:comment)
  end
end

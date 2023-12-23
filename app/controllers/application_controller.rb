class ApplicationController < ActionController::Base
  before_action :search
  
  def search
    @q = Item.ransack(params[:q])
    @results = @q.result.page(params[:page])
  end
  
end

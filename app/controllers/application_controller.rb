class ApplicationController < ActionController::Base
  before_action :search, unless: :devise_controller?
  
  def search
    @q = Item.ransack(params[:q])
    @results = @q.result.page(params[:page])
  end
  
end

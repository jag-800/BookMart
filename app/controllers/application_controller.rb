class ApplicationController < ActionController::Base
  before_action :search
  
  def search
    @q = Item.ransack(params[:q])
    @results = @q.result.page(params[:page])
    
    @unchecked_notices = current_customer.passive_notices.where(checked: false)
  end
  
end

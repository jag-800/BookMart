class ApplicationController < ActionController::Base
  before_action :search, :notice
  
  def search
    @q = Item.ransack(params[:q])
    @results = @q.result.page(params[:page])
  end
  
  def notice
    if current_customer
      @unchecked_notices = current_customer.passive_notices.where(checked: false)
    else
      admin = Admin.find(1)
      @unchecked_admin_notices = admin.passive_notices.where(checked: false)
    end
  end
  
end

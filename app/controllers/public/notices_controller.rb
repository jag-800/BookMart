class Public::NoticesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @notices = current_customer.passive_notices.page(params[:page]).per(20)
    @notices.where(checked: false).each do |notice|
      notice.update(checked: true)
    end
  end
end

class Public::NoticesController < ApplicationController
  before_action :authenticate
  
  def index
    @notices = current_customer.passive_notices.page(params[:page]).per(20)
    @notices.where(checked: false).each do |notice|
      notice.update(checked: true)
    end
  end
  
  private
  
  def authenticate
    unless customer_signed_in?
      redirect_to request.referer, alert: "ログイン前にこの操作を実行できません。"
    end
  end
end

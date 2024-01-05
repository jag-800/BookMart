class Admin::NoticesController < ApplicationController
  def index
    @notices = Notice.where.not(action: 'chat').page(params[:page]).per(20)
    @notices.where(checked: false).each do |notice|
      notice.update(checked: true)
    end
  end
end

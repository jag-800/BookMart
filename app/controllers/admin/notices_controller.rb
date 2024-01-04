class Admin::NoticesController < ApplicationController
  def index
    @notices = Notice.all.page(params[:page]).per(20)
    @notices.where(checked: false).each do |notice|
      notice.update(checked: true)
    end
  end
end

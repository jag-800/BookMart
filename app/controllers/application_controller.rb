class ApplicationController < ActionController::Base
  helper_method :notice, :admin_notice
  before_action :search
  before_action :check_guest_customer, only: [:create, :update, :edit, :new]

  def search
    @q = Item.ransack(params[:q])
    @results = @q.result.page(params[:page])
  end

  def notice
    if current_customer
      @unchecked_notices = current_customer ? current_customer.passive_notices.where(checked: false) : []
    else
      # @unchecked_notices = []
    end
  end

  def admin_notice
    @admin = Admin.find(1)
    @unchecked_admin_notices = @admin.passive_notices.where(checked: false)
  end

  private

  # ゲストユーザーかどうかを確認
  def check_guest_customer
    if current_customer.try(:guest?)
      redirect_to root_path, alert: "ゲストユーザーはこの操作を実行できません。"
    end
  end

end

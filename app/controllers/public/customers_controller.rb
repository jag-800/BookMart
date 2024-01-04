class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:show]
  before_action :set_current_customer, except: [:show]

  def mypage
  end

  def show
    @customer = Customer.find(params[:id])
    @items = @customer.items
    @tags = @items.flat_map(&:tag_list).uniq
    @tag_counts = @items.each_with_object(Hash.new(0)) do |item, counts|
      item.tag_list.each { |tag| counts[tag] += 1 }
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def set_current_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(:customer_image, :last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number)
  end

end

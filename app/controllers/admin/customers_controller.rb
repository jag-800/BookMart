class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page
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
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員ステータスを変更しました。"
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:is_active)
  end

end
